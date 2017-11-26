class SubcategoriesController < ApplicationController
  before_action :subcategory_resource, only: [:show]
  before_action :count_products

  def show
    @products = @category.products
  end

  private

  def count_products
    @products_count = Product.count
  end

  def subcategory_resource
    @category = Category.find(params[:id])
  end
end
