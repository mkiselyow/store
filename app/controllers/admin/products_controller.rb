class Admin::ProductsController < AdminsController

  def index
    @products = Product.order(:id)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy!
  end

  private

  def product_params
    params.require(:product).permit(:title, :size_a, :size_b, :size_h,
                                    :purchase_price, :mark_up, :price, :weight,
                                    :color_white, :color_black, :color_red, :color_yellow,
                                    :color_green, :color_blue, :color_violet, :brand,
                                    :material_plastic, :material_iron, :material_another,
                                    :material_wooden, :material_fabric, :supplier, :quantity,
                                    :image, :boys, :girls, :description, :image_cache,
                                    :image_id, :country, :product_code, :discount,
                                    :times_viewed, :category_id)
  end
end
