class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order, optional: true

  def count_line_item_price
    product.price * quantity unless product.price.nil?
  end
end
