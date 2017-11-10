class CategoriesController < ApplicationController
  # before_action :category_resource, only: [:edit, :update, :destroy]

  def show
    @category = Category.find(params[:id])
    @products = @category.products.all
  end

  private

  def category_params
    params.require(:category).permit(:name, subcategories_attributes: [:id, :name, :parent_category_id, :_destroy, subsubcategories_attributes: [:id, :name, :parent_category_id, :parent_subcategory_id, :_destroy]])
  end

  # def category_resource
  #   @category = Category.find(params[:id])
  # end
end
