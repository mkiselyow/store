class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      if current_item.quantity
        current_item.quantity += 1
      else
        current_item.update(quantity: 1)
      end
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def cart_total_price
    line_items.to_a.sum { |item| item.count_line_item_price.to_f }
    # cart_total_price = 0
    # self.line_items.each do |line_item|
    #   if line_item.product.price != nil
    #     cart_total_price += line_item.product.price * line_item.quantity
    #   end
    # end
    # cart_total_price
  end
end
