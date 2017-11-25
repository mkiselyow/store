class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true

  def price_discount
    if product.discount.present?
      product.price * (1-(product.discount * 0.01))
    else
      product.price
    end
  end

  def count_line_item_price
    price_discount * quantity unless price_discount.nil?
  end
end
