class CategoriesController < ApplicationController
  before_action :category_resource, only: %i[show]
  before_action :search_form, only: %i[show]
  before_action :count_products
  # caches_action :show

  def show
    @product_list = Product.order(sorting).where(category_id: @category.subtree_ids)
    @products = @product_list.paginate(page: params[:page], per_page: 16)
    @products_mobile = @product_list.paginate(page: params[:page], per_page: 12)
    # expires_in 1.days.seconds.to_i, :public => true
  end

  private

  def count_products
    @products_count = Product.count
  end

  def category_resource
    @category = Category.find(params[:id])
  end

  def search_form
    @search = Search.new
  end

  def sorting
    "#{params[:sort]} #{params[:order_type]}"
  end
end
