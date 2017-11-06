class Admin::CategoriesController < AdminsController

  before_action :category_resource, only: [:edit, :update, :destroy]

  def index
    @categories = Category.includes(:subcategories).includes(:subsubcategories).all
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy!
  end

  private

  def category_params
    params.require(:category).permit(:name, subcategories_attributes: [:id, :name, :parent_category_id, :_destroy, subsubcategories_attributes: [:id, :name, :parent_category_id, :parent_subcategory_id, :_destroy]])
  end

  def category_resource
    @category = Category.find(params[:id])
  end
end
