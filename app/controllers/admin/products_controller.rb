class Admin::ProductsController < AdminsController
  def index
    @products =
      if params[:product_code]
        Product.product_code_search(params[:product_code])
      else
        Product.order(:id)
      end.paginate(page: params[:page], per_page: 50)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy!
  end

  def import
    Product.import(params[:file])
    redirect_to admin_products_url#, notice: "Товары добавлены"
  end

  private

  def product_params
    params.require(:product).permit(:title, :size_a, :size_b, :size_h,
                                    :purchase_price, :mark_up, :price, :weight,
                                    :color_white, :color_black, :color_red, :color_yellow,
                                    :color_green, :color_blue, :color_violet, :brand,
                                    :material_plastic, :material_iron, :material_another,
                                    :material_wooden, :material_fabric, :mixed, :supplier, :quantity,
                                    :image, :sex_id, :description, :image_cache,
                                    :image_id, :country, :product_code, :discount,
                                    :times_viewed, :category_id, :other_desc, :general_category, :min_age, :max_age,
                                    image_products_attributes: %i[id image product_id _destroy])
  end
end
