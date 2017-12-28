class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items
  has_many :image_products, dependent: :destroy
  has_many :user_views, dependent: :destroy
  belongs_to :category
  belongs_to :sex

  translates :title, :description, :brand, :country

  validates :title, presence: true
  validates :price, presence: true

  before_destroy :ensure_not_referenced_by_any_line_item

  mount_uploader :image, ImageUploader

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
      unscoped
    end
  end

  def old_price
    if discount != 0
      price + ((price/100) * discount)
    end
  end

  def discount_price
    if price && discount
      price - ((price/100) * discount)
    end
  end

  def from_min_and_max
    "от #{ min_age } до #{ max_age } лет"
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
