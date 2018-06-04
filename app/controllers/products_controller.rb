class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :add_times_viewed, only: [:show]
  before_action :product_views_inc, only: [:show]
  before_action :only_admin_access, only: %i[new create update destroy edit]
  before_action :search_form, only: %i[index only_with_discount]

  def index
    @products_count = Product.count
    @products = if params[:query]
                  Product.text_search(params[:query]).order(sorting)
                else
                  Product.order(sorting)
                end
    @products_page = @products.paginate(page: params[:page], per_page: 24)
    @products_page_mobile = @products.paginate(page: params[:page], per_page: 12)
    @categories = Category.all
  end

  def only_with_discount
    @products_with_special_offers = Product.with_special_offers.paginate(page: params[:page], per_page: 20)
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    @image_products = @product.image_products
  end

  def show
    @user_views = current_user.user_views.last_six_views if current_user
  end

  def create
    @product = Product.create(product_params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Вы добавили продукт.' }
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

  def robots
    @products = Product.all
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

  def sorting
    "#{params[:sort]} #{params[:order_type]}"
  end

  def product_views_inc
    if user_signed_in?
      @userview = UserView.where(product_id: @product.id).where(user_id: current_user.id)
      if @userview.present?
        @userview.update(updated_at: Time.now)
      else
        @product.user_views.create(user_id: current_user.id)
      end
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def search_form
    @search = Search.new
  end

  def product_params
    params.require(:product).permit(:title, :size_a, :size_b, :size_h,
                                    :purchase_price, :mark_up, :price, :weight,
                                    :color_white, :color_black, :color_red, :color_yellow,
                                    :color_green, :color_blue, :color_violet, :brand,
                                    :material_plastic, :material_iron, :material_another,
                                    :material_wooden, :material_fabric, :mixed, :supplier, :quantity,
                                    :image, :sex_id, :description, :image_cache,
                                    :image_id, :country, :product_code, :discount,
                                    :times_viewed, :category_id, :general_category, :other_desc, :min_age, :max_age,
                                    image_products_attributes: %i[id image product_id _destroy])
  end
end
