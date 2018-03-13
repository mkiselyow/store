class Admin::ProductsController < AdminsController
  def index
    @products =
      if params[:product_code]
        Product.product_code_search(params[:product_code])
      else
        Product.order('created_at DESC')
      end.paginate(page: params[:page], per_page: 50)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy!
  end

  def import
    Product.import(params[:file])
    redirect_to admin_products_url, notice: 'Товары добавлены'
  end

  def delete_products_created_today
    Product.products_created_today.each(&:destroy)
    redirect_to admin_products_url, notice: 'Товары удалены'
  end

  def set_exchange_rates
    @brands_all = Product.select('brand').map {|prod| prod.brand}.uniq
  end

  def update_products_with_exchange_rates
    category_ids =  params[:category][:category_id].reject(&:blank?)
    selected_brands = params[:brand][:brand].reject(&:blank?)
    @selected_products = category_ids.inject(nil) do |acc, cat| 
        acc ||= Product.where(category_id: cat); 
        acc + Product.where(category_id: cat)
    end
    @selected_products = Product.where(id: @selected_products.map(&:id))
    if !selected_brands.empty?
        @selected_products = selected_brands.inject(nil) do |acc, brand| 
            acc ||= selected_products_by_category_ids.where(brand: brand); 
            acc + selected_products_by_category_ids.where(brand: brand)
        end
    end
    rates = params[:current_rates].to_f / params[:last_rates].to_f
    if @selected_products
        @selected_products.each do |product|
            product.update(purchase_price: product.purchase_price*rates)
        end
        redirect_to admin_products_url, notice: 'Товары обновлены'
    else
        redirect_to admin_products_url, notice: 'Товары не найдены'
    end
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