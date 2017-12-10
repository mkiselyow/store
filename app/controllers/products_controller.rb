class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :add_times_viewed, only: [:show]
  before_action :only_admin_access, only: [:new, :create, :update, :destroy, :edit]
  helper_method :sort_column, :sort_direction

  def index
    @products_count = Product.count
    @rows_count = (@products_count/4)
    @search = Search.new
    @products = Product.order(sort_column + ' ' + sort_direction)
    @products_page = @products.paginate(page: params[:page], per_page: 24)
    @products_page_mobile = @products.paginate(page: params[:page], per_page: 12)
    @categories = Category.all
    @sexes = Sex.all
    @products_most_viewed = Product.where('times_viewed >= 0').order('times_viewed DESC').limit(20)
    @products_wth_special_offers = Product.where('discount != 0').limit(20)
    @newest_ten_products = Product.order('created_at DESC').limit(8)
  end

  def new
    @product = Product.new
    @product.image_products.build
  end

  def create
    @product = Product.create(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Вы создали продукт.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @product.price = @product.price_mark_up
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Продукт был успешно обновлен.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Продукт успешно удален.' }
      format.json { head :no_content }
    end
  end

  def delete_image
    @product = Product.find(params[:id])
    @product.image = ''
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Изображение было удалено.' }
      format.json { render :show, status: :ok, location: @product }
    end
  end

  # считаем кол-во просмотров
  def add_times_viewed
    if @product.times_viewed
      times = @product.times_viewed += 1
      @product.update(times_viewed: times)
    else
      @product.update(times_viewed: 1)
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
        format.html
      end
    end
  end

  private

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :size_a, :size_b, :size_h,
                                    :purchase_price, :mark_up, :price, :weight,
                                    :color_white, :color_black, :color_red, :color_yellow,
                                    :color_green, :color_blue, :color_violet, :brand,
                                    :material_plastic, :material_iron, :material_another,
                                    :material_wooden, :material_fabric, :supplier, :quantity,
                                    :image, :sex_id, :description, :image_cache,
                                    :image_id, :country, :product_code, :discount,
                                    :times_viewed, :category_id, :general_category, :other_desc, :min_age, :max_age,
                                    image_products_attributes: [:id, :image, :product_id, :_destroy])
  end
end
