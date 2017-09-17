class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def count_line_item_price
    self.product.price * self.quantity
  end
end
