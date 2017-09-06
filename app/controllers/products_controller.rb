class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  # before_action :set_price, only: [:update, :edit]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    if params[:boys]
      @products = Product.search_by_boys(params[:boys])
    else
      @products = Product.search_by_boys("false")
    end
    if params[:girls]
      @products = Product.search_by_girls(params[:girls])
    else
      @products = Product.search_by_girls("false")
    end
    if params[:color_yellow]
      @products = Product.search_by_color_yellow(params[:color_yellow])
    else
      @products = Product.search_by_color_yellow("false")
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
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    # if (@product.price == nil) && @product.purchase_price && (@product.discount || @product.mark_up)
    #   @product.price = @product.purchase_price*@product.mark_up/100 + @product.purchase_price
    #   if @product.discount
    #     @product.price = @product.price-@product.price*@product.discount/100
    #   end
    # end
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
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
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
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
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image
    @product = Product.find(params[:id])
    # @product.image.file.delete
    @product.image = ''
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      format.json { render :show, status: :ok, location: @product }
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
      params.require(:product).permit(:title, :size_a, :size_b, :size_h, :purchase_price, :mark_up, :price, :weight, :color_white, :color_black, :color_red, :color_yellow, :color_green, :color_blue, :color_violet, :brand, :material_plastic, :material_iron, :material_another, :material_wooden, :material_fabric, :supplier, :quantity, :image, :boys, :girls, :description, :image_cache, :image_id, :country, :product_code, :discount)
    end
end
