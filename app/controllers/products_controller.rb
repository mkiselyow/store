class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :add_times_viewed, only: [:show]
  before_action :only_admin_access, only: [:new, :create, :update, :destroy, :edit]
  helper_method :sort_column, :sort_direction

  def index
    @products_count = Product.count
    @rows_count = (@products_count/4)
    @products =
      if params.present?
        puts 'HAVING params[:params.present?] SEARCHED'
        if params[:title]
          # @products = Product.search_by_title(params[:title])
          @products = Product.where('title LIKE ?', "%#{params[:title]}%")
        else
          @products = Product.all.to_a
          if params[:category_id]
            @products = Product.where(category_id: params[:category_id])
            puts 'HAVING params[:category_id] SEARCHED'
          end
          if params[:sex_id]
            @products = Product.where(sex_id: params[:sex_id])
            puts 'HAVING params[:sex_id] SEARCHED'
          end
          if params[:min_sum] && params[:max_sum]
            @products = Product.where(price: (params[:min_sum])..(params[:max_sum]))

            # puts 'HAVING params[:sex_id] SEARCHED'
          end
          if params[:brand]
            @products &= Product.where('brand LIKE ?', "%#{params[:brand]}%")
            puts 'HAVING params[:brand] SEARCHED'
          end
          if params[:color_black]
            @products &= Product.search_by_color_black(params[:color_black]).to_a
            puts 'HAVING params[:color_black] SEARCHED'
            # else
            #   @products = Product.search_by_color_black("false")
          end
          if params[:color_white]
            @products &= Product.search_by_color_white(params[:color_white]).to_a
            puts 'HAVING params[:color_white] SEARCHED'
            # else
            #   @products = Product.search_by_color_white("false")
          end
          if params[:color_yellow]
            @products &= Product.search_by_color_yellow(params[:color_yellow]).to_a
            puts 'HAVING params[:color_yellow] SEARCHED'
            puts "color_yellow count #{Product.search_by_color_yellow(params[:color_yellow]).count} #{@products.count}"
            # else
            #   @products = Product.search_by_color_yellow("false")
          end
          if params[:color_red]
            @products &= Product.search_by_color_red(params[:color_red]).to_a
            puts 'HAVING params[:color_red] SEARCHED'
            # else
            #   @products = Product.search_by_color_red("false")
          end
          if params[:color_green]
            @products &= Product.search_by_color_green(params[:color_green]).to_a
            puts 'HAVING params[:color_green] SEARCHED'
            # else
            #   @products = Product.search_by_color_green("false")
          end
          if params[:color_blue]
            @products &= Product.search_by_color_blue(params[:color_blue]).to_a
            puts 'HAVING params[:color_blue] SEARCHED'
            # else
            #   @products = Product.search_by_color_blue("false")
          end
          if params[:color_violet]
            @products &= Product.search_by_color_violet(params[:color_violet]).to_a
            puts 'HAVING params[:color_violet] SEARCHED'
            # else
            #   @products = Product.search_by_color_violet("false")
          end
          if params[:material_another]
            @products &= Product.search_by_material_another(params[:material_another]).to_a
            puts 'HAVING params[:material_another] SEARCHED'
            # else
            #   @products = Product.search_by_material_another("false")
          end
          if params[:material_wood]
            @products &= Product.search_by_material_wood(params[:material_wood]).to_a
            puts 'HAVING params[:material_wood] SEARCHED'
            # else
            #   @products = Product.search_by_material_wood("false")
          end
          if params[:material_iron]
            @products &= Product.search_by_material_iron(params[:material_iron]).to_a
            puts 'HAVING params[:material_iron] SEARCHED'
            # else
            #   @products = Product.search_by_material_iron("false")
          end
          if params[:material_fabric]
            @products &= Product.search_by_material_fabric(params[:material_fabric]).to_a
            puts 'HAVING params[:material_fabric] SEARCHED'
            # else
            #   @products = Product.search_by_material_fabric("false")
          end
          if params[:material_plastic]
            @products &= Product.search_by_material_plastic(params[:material_plastic]).to_a
            puts 'HAVING params[:material_plastic] SEARCHED'
            puts "material_plastic count #{Product.search_by_material_plastic(params[:material_plastic]).count} #{@products.count}"
            # else
            #   @products = Product.search_by_material_plastic("false")
          end
          @products = Product.order(sort_column + ' ' + sort_direction)
        end
      end
    @products_page = @products.paginate(page: params[:page], per_page: 24)
    @products_page_mobile = @products.paginate(page: params[:page], per_page: 12)
    @categories = Category.all
    @sexes = Sex.all
    @products_most_viewed = Product.where('times_viewed >= 0').order('times_viewed DESC').limit(20)
    @products_wth_special_offers = Product.where('discount != 0').limit(20)
    @newest_ten_products = Product.order('created_at DESC').limit(8)
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.image_products.build
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
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

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
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

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Продукт успешно удален.' }
      format.json { head :no_content }
    end
  end

  def delete_image
    @product = Product.find(params[:id])
    # @product.image.file.delete
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
