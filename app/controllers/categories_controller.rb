class CategoriesController < ApplicationController
  before_action :category_resource, only: [:show]
  before_action :count_products

  def show
    @products = @category.products.paginate(page: params[:page], per_page: 18)
    # @subcategory_product = @category.subcategories.where(parent_category_id: params[:id])
    @subcategory_product = @category.subtree
    @search = Search.new
  end

  def index
    @products = Product.order(:id).paginate(page: params[:page], per_page: 18)
    @search = Search.new
  end

  private

  def count_products
    @products_count = Product.count
  end

  def category_resource
    @category = Category.find(params[:id])
  end
end
