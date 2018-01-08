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

  def count_price
    price = (purchase_price * mark_up / 100 + purchase_price) * (100 - discount) / 100
    update_column(:price, price)
  end

  def price_mark_up
    purchase_price + (purchase_price * (mark_up * 0.01))
  end

  def self.text_search(query)
    if query.present?
      where('title @@ :q or description @@ :q', q: query)
    else
      unscoped
    end
  end

  def old_price
    if price && discount != 0 && discount != nil
      price + ((price/100) * discount)
    end
  end

  def discount_price
    price - ((price / 100) * discount) if price && discount
  end

  def from_min_and_max
    "от #{min_age} до #{max_age} лет"
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
    #options = { headers: true, encoding:'windows-1251:utf-8', :row_sep => "\r\n", :col_sep => ";", :skip_blanks => true} #, :row_sep => "\r\n"
    options = { headers: true, encoding: "UTF-8", :row_sep => :auto, :col_sep => "\t", :skip_blanks => true}
    # CSV.foreach(file, options) do |row|
    CSV.foreach(file.path, options) do |row|
      # # unless Product.find_by(product_code: row.to_hash["Артикул"])
      #   product = Product.create!(
      #     title:                row.to_hash["Название на русском"],
      #     size_a:               (row.to_hash["Длина см."] ? row.to_hash["Длина см."].to_i*10 : nil),
      #     size_b:               (row.to_hash["Ширина см."] ? row.to_hash["Ширина см."].to_i*10 : nil),
      #     size_h:               (row.to_hash["Высота см."] ? row.to_hash["Высота см."].to_i*10 : nil),
      #     purchase_price:       (row.to_hash["Цена грн."] ? row.to_hash["Цена грн."].to_f : nil),
      #     mark_up:              (row.to_hash["Наценка"] ? row.to_hash["Наценка"].to_f : 100),
      #     # price:                (row.to_hash["Цена грн."]*row.to_hash["Наценка"]||100),
      #     weight:               (row.to_hash["Вес г."] ? row.to_hash["Вес г."].to_f : nil),
      #     #color_white:
      #     #color_black:
      #     #color_red:
      #     #color_yellow:
      #     #color_green:
      #     #color_blue:
      #     #color_violet:
      #     brand:                row.to_hash["Торговая марка"],
      #     material_plastic: (if row.to_hash["Материал"]
      #                         row.to_hash["Материал"].match(%r/пластик|полимерные/i) ? true : false
      #                       end),
      #     material_iron:    (if row.to_hash["Материал"]
      #                         row.to_hash["Материал"].match(%r/металл/i) ? true : false
      #                       end),
      #     material_another: (if row.to_hash["Материал"]
      #                         row.to_hash["Материал"].match(%r/картон|винил|резина|летекс|ФОМ|гипс|бумага/i) ? true : false
      #                       end),
      #     material_wooden:  (if row.to_hash["Материал"]
      #                         row.to_hash["Материал"].match(%r/дерево/i) ? true : false
      #                       end),
      #     material_fabric:  (if row.to_hash["Материал"]
      #                         row.to_hash["Материал"].match(%r/ткань|плюш/i) ? true : false
      #                       end),
      #     mixed:            (if row.to_hash["Материал"]
      #                         row.to_hash["Материал"].match(%r/смешанный/i) ? true : false
      #                       end),
      #     #supplier:
      #     #quantity:              row.to_hash["Количество"],
      #     sex_id:              (if row.to_hash["Пол"] && row.to_hash["Пол"].match(%r/мальчик/i)
      #                             1# 1# 5 #1
      #                           elsif row.to_hash["Пол"] && row.to_hash["Пол"].match(%r/девочка/i)
      #                             2# 2# 3 #2
      #                           else
      #                             3# 3# 4 #3
      #                           end),
      #     #description:
      #     #image_cache:
      #     #image_id:
      #     #country:
      #     product_code:          row.to_hash["Артикул"],
      #     #discount:             row.to_hash["Скидка"],
      p    "=========================================================================== =========================================================================== ========================================================================== #{(row.to_hash["Категория"].split(", ").last ? (Category.all.map {|cat| cat.name }.include?(row.to_hash["Категория"].split(", ").last) ? Category.where(name: row.to_hash["Категория"].split(", ").last).id : 1) : 1)}"
      #     #other_desc:
      #     #general_category:
      #     #max_age:
      #     min_age:              row.to_hash["Возраст"] )
      # if row.to_hash["Изображение"]
      #   product.update_column(:image, "#{Cloudinary::Uploader.upload(row.to_hash["Изображение"])["secure_url"]}")
      # end
    end
  end

  # file = File.open('/home/max/Рабочий стол/new.csv')

  # убеждаемся в отсутствии товарных позиций, ссылающихся на данный товар
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'существуют товарные позиции')
      false
    end
  end
end
