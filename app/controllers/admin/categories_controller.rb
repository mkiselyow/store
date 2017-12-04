class Admin::CategoriesController < AdminsController

  before_action :category_resource, only: [:edit, :update, :destroy, :show]
  after_action do
    Category::CATEGORIES_SELECT = Category::get_collection_of_categories_ids
  end

  def index
    # @categories = Category.includes(:subcategories).includes(:subsubcategories).all
    @categories = Category.where(ancestry: nil)
    @category = Category.new(parent_id: params[:parent_id])
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
    @subcategory = Category.new
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
    # params.require(:category).permit(:name, subcategories_attributes: [:id, :name, :parent_id, :_destroy])
    params.require(:category).permit(:name, :parent_id)
  end

  def subcategory_params
    params.require(:category).permit(:name, :parent)
  end

  def category_resource
    @category = Category.find(params[:id])
  end
end
