class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_many :image_products, dependent: :destroy
  belongs_to :category
  belongs_to :sex

  validates :title, presence: true
  validates :category_id, presence: true
  validates :price, presence: true

  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image, ImageUploader
  # extend Textacular
  include PgSearch
  pg_search_scope :search_by_discount,          against: :discount
  pg_search_scope :search_by_title,             against: :title
  pg_search_scope :search_by_brand,             against: :brand
  pg_search_scope :search_by_category,          against: :category_id
  pg_search_scope :search_by_sex,               against: :sex_id
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
      # where(nil)
      unscoped
    end
  end

  def discount_price
    if price && discount
      price - ((price/100) * discount)
    end
  end

  def self.latest
    Product.order(:updated_at).last
  end

  def self.title_search(title)
    where('title LIKE ?', "%#{title}%")
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
