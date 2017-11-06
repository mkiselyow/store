class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :add_times_viewed, only: [:show]
  before_action :only_admin_access, only: [:new, :create, :update, :destroy, :edit]

  # before_action :set_price, only: [:update, :edit]

  # GET /products
  # GET /products.json
  def index
    @products_count = Product.count
    @products = Product.all
    @categories = Category.all
    @products_most_viewed = Product.where('times_viewed >= 0').order('times_viewed DESC').limit(20)
    @products_wth_special_offers = Product.where('discount != 0').limit(20)
    @newest_ten_products = Product.order('created_at DESC').limit(8)
    if params.present? # params[:one].present?
      puts 'HAVING params[:params.present?] SEARCHED'
      if params[:title]
        @products = Product.search_by_title(params[:title])
      else
        @products = Product.all.to_a
        if params[:boys]
          @products &= Product.search_by_boys(params[:boys]).to_a
          puts 'HAVING params[:boys] SEARCHED'
          puts "boys count #{Product.search_by_boys(params[:boys]).count} #{@products.count}"
          # else
          #   @products = Product.search_by_boys("false")
        end
        if params[:girls]
          @products &= Product.search_by_girls(params[:girls]).to_a
          puts 'HAVING params[:girls] SEARCHED'
          # else
          #   @products = Product.search_by_girls("false")
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
        @products = Product.where(id: @products.map(&:id))
      end
    end
    # if params[:boys]
    # @search = params[:search_boys], params[:color_white], params[:color_black], params[:color_red], params[:color_yellow], params[:color_green], params[:color_blue], params[:color_violet], params[:material_plastic], params[:material_iron], params[:material_another], params[:material_wooden], params[:material_fabric], params[:girls]
    # @products = Product.text_search(params[:query])#.page(params[:page]).per_page(3)
    # @products = Product.search(params[:search_boys])#.page(params[:page]).per_page(3)
    #   @products = Product.search(params[:boys])#*@search)
    # end
  end

  # GET /products/1
  # GET /products/1.json
  def show; end

  # GET /products/new
  def new
    @product = Product.new
    3.times do
      @product.image_products.build
    end
  end

  # GET /products/1/edit
  def edit; end

  # POST /products
  # POST /products.json
  def create
    @product = Product.create(product_params)
    # if (@product.price == nil) && @product.purchase_price && (@product.discount || @product.mark_up)
    #   @product.price = @product.purchase_price*@product.mark_up/100 + @product.purchase_price
    #   if @product.discount
    #     @product.price = @product.price-@product.price*@product.discount/100
    #   end
    # end
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
    # if params[:image_id].present?
    #   preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
    #   raise "Invalid upload signature" if !preloaded.valid?
    #   @product.image_id = preloaded.identifier
    # end
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

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # def set_price
  #   @product = Product.find(params[:id])
  #   @product.price = @product.purchase_price*@product.mark_up/100 + @product.purchase_price
  #   if @product.discount
  #     @product.price = @product.price-@product.price*@product.discount/100
  #   end
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:title, :size_a, :size_b, :size_h,
                                    :purchase_price, :mark_up, :price, :weight,
                                    :color_white, :color_black, :color_red, :color_yellow,
                                    :color_green, :color_blue, :color_violet, :brand,
                                    :material_plastic, :material_iron, :material_another,
                                    :material_wooden, :material_fabric, :supplier, :quantity,
                                    :image, :boys, :girls, :description, :image_cache,
                                    :image_id, :country, :product_code, :discount,
                                    :times_viewed, :category_id, image_products_attributes: [:id, :image, :product_id, :_destroy])
  end
end
