class Admin::CategoriesController < AdminsController

  before_action :category_resource, only: [:edit, :update]

  def index
    @categories = Category.includes(:subcategories).all
    @category = Category.new
    @category.subcategories.build
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, subcategories_attributes: %i[id name parent_category_id _destroy])
  end

  def category_resource
    @category = Category.find(params[:id])
  end
end
