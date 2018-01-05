class PagesController < ApplicationController
  def main
    @products_count = Product.count
    @rows_count = (@products_count / 4)
    @search = Search.new
    @products = Product.order(:id).paginate(page: params[:page], per_page: 16)
    @products_mobile = Product.order(:id).paginate(page: params[:page], per_page: 12)
    @categories = Category.all.includes(:products)
    @products_most_viewed = Product.where('times_viewed >= 0').order('times_viewed DESC').limit(20)
    @products_with_special_offers = Product.with_special_offers.limit(20)
    @newest_ten_products = Product.order('created_at DESC').limit(8)
  end
end
