class Admin::CategoriesController < AdminsController
  before_action :category_resource, only: %i[edit update destroy show]
  after_action :select_resource, only: [:create]

  def index
    @categories = Category.where(ancestry: nil).order(:position)
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

  def sort
    params[:category].each_with_index do |id, index|
      Category.find_by_id(id).update(position: index + 1)
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id, :position)
  end

  def category_resource
    @category = Category.find(params[:id])
  end

  def select_resource
    Category.get_collection_of_categories_ids
  end
end
