class PagesController < ApplicationController
  def main
    @products_count = Product.count
    @rows_count = (@products_count/4)
    @products = Product.order(:id)
    @categories = Category.all
    @products_most_viewed = Product.where('times_viewed >= 0').order('times_viewed DESC').limit(20)
    @products_wth_special_offers = Product.where('discount != 0').limit(20)
    @newest_ten_products = Product.order('created_at DESC').limit(8)
  end
end
