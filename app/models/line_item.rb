class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def count_line_item_price
    if self.product.price != nil
      self.product.price * self.quantity
    end
  end
end
