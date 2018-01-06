class SearchesController < ApplicationController
  before_action :search_resources, only: %i[show update]

  def new
    @search = Search.new
  end

  def create
    @search = Search.create(product_params)
    redirect_to @search, notice: "Найдено #{@search.products.count} товаров"
  end

  def show
    @products = @search.products.order("#{params[:sort]} #{params[:order_type]}")
  end

  def update
    @search.update(product_params)
    redirect_back(fallback_location: search_path(@search))
  end

  private

  def search_resources
    @search = Search.find(params[:id])
  end

  def product_params
    params.require(:search).permit(:title, :price, :product_code, :min_price, :max_price,
                                   :min_age, :max_age,
                                   :color_white, :color_black, :color_red, :color_yellow,
                                   :color_green, :color_blue, :color_violet, :brand,
                                   :material_plastic, :material_iron, :material_another,
                                   :material_wooden, :material_fabric, :material_mixed, :sex_id)
  end
end
