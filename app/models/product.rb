class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_many :image_products, dependent: :destroy
  has_many :user_views, dependent: :destroy
  belongs_to :category
  belongs_to :sex

  validates :title, presence: true
  validates :price, presence: true, unless: :purchase_price && :mark_up

  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :image_products, allow_destroy: true

  after_save :count_price, if: proc { |u| u.mark_up_changed? || u.discount_changed? || u.purchase_price_changed? }

  scope :with_special_offers, -> { where('discount != 0') }
  scope :twenty_most_views, -> { where('times_viewed >= 0').order('times_viewed DESC').limit(20) }
  scope :newest_products, -> { order('created_at DESC').limit(12) }

  def count_price
    price = (purchase_price * mark_up / 100 + purchase_price) * (100 - discount) / 100
    update_column(:price, price)
  end

  def price_mark_up
    purchase_price + (purchase_price * (mark_up * 0.01))
  end

  def self.text_search(query)
    if query.present?
      where('title @@ :q or product_code @@ :q', q: query)
    else
      unscoped
    end
  end

  def old_price
    if purchase_price && discount
      purchase_price + ((purchase_price/100) * mark_up)
    end
  end

  def discount_price
    price - ((price / 100) * discount) if price && discount
  end

  def from_min_and_max
    "#{minim_age} #{maxim_age} лет"
  end

  def minim_age
    "от #{min_age} " if min_age.present?
  end

  def maxim_age
    "до #{max_age} " if max_age.present?
  end

  def full_name_product
    "#{title} - #{brand}"
  end

  def self.latest
    Product.order(:updated_at).last
  end

  def self.product_code_search(product_code)
    where('product_code LIKE ?', "%#{product_code}%")
  end

  def self.import(file)
    file_encoding = CharlockHolmes::EncodingDetector.detect(file.read)[:encoding]
    count_tabs = CSV.read(file.path, "r:#{file_encoding}").join.scan("\t").count
    count_semicolon = CSV.read(file.path, "r:#{file_encoding}").join.scan(";").count
    if count_tabs > count_semicolon
      current_col_sep = "\t"
    elsif count_tabs < count_semicolon
      current_col_sep = ";"
    else
      raise ArgumentError.new("CSV FILE IS NOT DEFINED")
    end
    options = { headers: true, encoding: file_encoding, :row_sep => :auto, :col_sep => current_col_sep, :skip_blanks => true}
    CSV.foreach(file.path, options) do |row|
      params  = {
        title:                row.to_hash["Название на русском"],
        size_a:               (row.to_hash["Длина см."] ? row.to_hash["Длина см."].to_i : nil),
        size_b:               (row.to_hash["Ширина см."] ? row.to_hash["Ширина см."].to_i : nil),
        size_h:               (row.to_hash["Высота см."] ? row.to_hash["Высота см."].to_i : nil),
        purchase_price:       (row.to_hash["Цена грн."] ? row.to_hash["Цена грн."].to_f : nil),
        mark_up:              (row.to_hash["Наценка"] ? row.to_hash["Наценка"].to_i : 100),
        # price:                (row.to_hash["Цена грн."]*row.to_hash["Наценка"]||100),
        weight:               (row.to_hash["Вес г."] ? row.to_hash["Вес г."].to_f : nil),
        brand:                row.to_hash["Торговая марка"],
        material_plastic: (if row.to_hash["Материал"]
                            row.to_hash["Материал"].match(%r/пластик|полимерные/i) ? true : false
                          end),
        material_iron:    (if row.to_hash["Материал"]
                            row.to_hash["Материал"].match(%r/металл/i) ? true : false
                          end),
        material_another: (if row.to_hash["Материал"]
                            row.to_hash["Материал"].match(%r/картон|винил|резина|летекс|ФОМ|гипс|бумага/i) ? true : false
                          end),
        material_wooden:  (if row.to_hash["Материал"]
                            row.to_hash["Материал"].match(%r/дерево/i) ? true : false
                          end),
        material_fabric:  (if row.to_hash["Материал"]
                            row.to_hash["Материал"].match(%r/ткань|плюш/i) ? true : false
                          end),
        mixed:            (if row.to_hash["Материал"]
                            row.to_hash["Материал"].match(%r/смешанный/i) ? true : false
                          end),
        sex_id:           (if row.to_hash["Пол"] && row.to_hash["Пол"].match(%r/мальчик/i)
                             1# 1# 5 #1
                           elsif row.to_hash["Пол"] && row.to_hash["Пол"].match(%r/девочка/i)
                             2# 2# 3 #2
                           else
                             3# 3# 4 #3
                           end),
        product_code:          row.to_hash["Артикул"],
        discount:              row.to_hash["Скидка"].nil? ? 0 : row.to_hash["Скидка"].to_i,
        category_id: (row.to_hash["Категория"] ? (Category.all.map {|cat| cat.name}.include?(row.to_hash["Категория"]) ? Category.find_by(name: row.to_hash["Категория"]).id : 169) : 169),
        quantity:             (row.to_hash["Количество"] ? row.to_hash["Количество"].to_i : nil),
        min_age:              row.to_hash["Возраст"] 
      }
      product = Product.find_by(product_code: row.to_hash["Артикул"])
      if product
        product.update(params)
      else
        Product.create!(params)
      end
    end
  end

  def self.products_created_today
    self.where("created_at >= ?", 20.minutes.ago)
  end

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'существуют товарные позиции')
      false
    end
  end
end
