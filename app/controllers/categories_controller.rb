class CategoriesController < ApplicationController
  before_action :category_resource, only: [:show]
  before_action :count_products

  def show
    @products = @category.products.all
  end

  def index
    @products = Product.order(:id)
  end

  private

  def category_params
    params.require(:category).permit(:name, subcategories_attributes: [:id, :name, :parent_category_id, :_destroy, subsubcategories_attributes: [:id, :name, :parent_category_id, :parent_subcategory_id, :_destroy]])
  end

  def count_products
    @products_count = Product.count
  end

  def category_resource
    @category = Category.find(params[:id])
  end
end
