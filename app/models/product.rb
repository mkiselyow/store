class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  # extend Textacular

  # belongs_to :searchable, polymorphic: true
  # mount_uploader :image, ImageUploader
  
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

  def self.text_search(query)
    if query.present?
      # basic_search({title: query, description: query}, false)
      # basic_search(query)
      # query.split.each do |query|
      #   advanced_search(query)
      # end
      where("title @@ :q or description @@ :q", q: query)
    else
      # where(nil)
      unscoped
    end
  end

  # def self.searchable_language
  #   'russian'
  # end

  # def self.searchable_columns
  #   [:title, :description]
  # end
end
