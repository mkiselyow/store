class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true

  def price_discount
    product.price
  end

  def count_line_item_price
    price_discount * quantity
  end
end
