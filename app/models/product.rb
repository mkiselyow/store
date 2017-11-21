class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_many :image_products, dependent: :destroy
  belongs_to :category
  validates :title, presence: true

  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image, ImageUploader
  # extend Textacular
  include PgSearch
  pg_search_scope :search_by_discount,          against: :discount
  pg_search_scope :search_by_title,             against: :title
  pg_search_scope :search_by_boys,              against: :boys
  pg_search_scope :search_by_girls,             against: :girls
  pg_search_scope :search_by_brand,             against: :brand
  pg_search_scope :search_by_category,          against: :category_id
  pg_search_scope :search_by_color_white,       against: :color_white
  pg_search_scope :search_by_color_black,       against: :color_black
  pg_search_scope :search_by_color_red,         against: :color_red
  pg_search_scope :search_by_color_yellow,      against: :color_yellow
  pg_search_scope :search_by_color_green,       against: :color_green
  pg_search_scope :search_by_color_blue,        against: :color_blue
  pg_search_scope :search_by_color_violet,      against: :color_violet
  pg_search_scope :search_by_material_another,  against: :material_another
  pg_search_scope :search_by_material_plastic,  against: :material_plastic
  pg_search_scope :search_by_material_iron,     against: :material_iron
  pg_search_scope :search_by_material_wood,     against: :material_wood
  pg_search_scope :search_by_material_fabric,   against: :material_fabric

  accepts_nested_attributes_for :image_products, allow_destroy: true

  after_save :count_price, if: proc { |u| u.mark_up_changed? || u.discount_changed? || u.purchase_price_changed? }

  def count_price
    # if self.update_attributes(params[:mark_up]) || self.update_attributes(params[:discount]) || self.update_attributes(params[:purchase_price])
    # if self.price == nil
    price = (purchase_price * mark_up / 100 + purchase_price) * (100 - discount) / 100
    update_column(:price, price)
    # self.update(:price => price)
    # end
    # end
  end

  def self.text_search(query)
    if query.present?
      # basic_search({title: query, description: query}, false)
      # basic_search(query)
      # query.split.each do |query|
      #   advanced_search(query)
      # end
      # where('name LIKE ?', "%#{params[:query]}%")
      where('title @@ :q or description @@ :q', q: query)
    else
      # where(nil)
      unscoped
    end
  end

  def self.search(boys) # , search_girls, search_color_white, search_color_black, search_color_red, search_color_green, search_color_yellow, search_color_violet, search_color_blue, search_material_wooden, search_material_iron, search_material_another, search_material_fabric, search_material_plastic)
    if boys.present?
      where(boys: boys != 'false')
    # elsif search_girls.present?
    #   where(:girls => search_boys != "false")
    else
      where(boys: boys == 'false')
    end
  end

  def discount_price
    price - ((price/100) * discount)
  end

  def self.latest
    Product.order(:updated_at).last
  end

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
