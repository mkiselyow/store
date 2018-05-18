class PagesController < ApplicationController
  def main
    @products_count = Product.count
    @rows_count = (@products_count / 4)
    @search = Search.new
    @products = Product.order(:id).paginate(page: params[:page], per_page: 12)
    @products_mobile = Product.order(:id).paginate(page: params[:page], per_page: 12)
    @categories = Category.all.includes(:products)
    @products_most_viewed = Product.twenty_most_views
    @products_with_special_offers = Product.with_special_offers.limit(20)
    @newest_ten_products = Product.newest_products
    expires_in 10.days.seconds.to_i, :public => true
  end
end
