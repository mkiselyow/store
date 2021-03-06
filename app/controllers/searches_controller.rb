class SearchesController < ApplicationController
  before_action :search_resources, only: %i[show update]
  before_action :annulment, only: %i[update]

  def new
    @search = Search.new
  end

  def create
    @search = Search.create(product_params)
    redirect_to @search, notice: t('search.result', products_count: @search.products.count)
  end

  def show
    @products = @search.products.order(sorting).paginate(page: params[:page], per_page: 20)
    @products_mobile = @search.products.order(sorting).paginate(page: params[:page], per_page: 12)
  end

  def update
    @search.update(product_params)
    redirect_to search_path(@search), notice: t('search.result', products_count: @search.products.count)
  end

  private

  def annulment
    @search.update(title: nil, product_code: nil, min_price: nil,
                   max_price: nil, brand: nil, min_age: nil,
                   max_age: nil, sex_id: nil, category_id: nil)
  end

  def search_resources
    @search = Search.find(params[:id])
  end

  def sorting
    "#{params[:sort]} #{params[:order_type]}"
  end

  def product_params
    params.require(:search).permit(:title, :price, :product_code, :min_price, :max_price,
                                   :min_age, :max_age, :color_white, :color_black, :color_red,
                                   :color_yellow, :color_green, :color_blue, :color_violet,
                                   :brand, :material_plastic, :material_iron, :material_another,
                                   :material_wooden, :material_fabric, :material_mixed,
                                   :sex_id, :category_id)
  end
end
