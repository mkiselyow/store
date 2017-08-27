class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  after_save :count_price, :if => Proc.new { |u| u.mark_up_changed? || u.discount_changed? || u.purchase_price_changed?}

  def count_price
    # if self.update_attributes(params[:mark_up]) || self.update_attributes(params[:discount]) || self.update_attributes(params[:purchase_price])
      # if self.price == nil
        price = (self.purchase_price * self.mark_up / 100 + self.purchase_price) * (100 - self.discount) / 100
        update_column(:price, price)
        # self.update(:price => price)
      # end
    # end
  end
end
