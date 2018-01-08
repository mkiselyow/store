class Search < ApplicationRecord

  def products
    @products ||= find_products
  end

  private

  def find_products
    products = Product.order(:id)
    products = products.where(brand: brand) if brand.present?

    products = products.where(category_id: category_id) if category_id.present?
    products = products.where(sex_id: sex_id) if sex_id.present?

    products = products.where('price >= ?', min_price) if min_price.present?
    products = products.where('price <= ?', max_price) if max_price.present?
    products = products.where('min_age >= ?', min_age) if min_age.present?
    products = products.where('max_age <= ?', max_age) if max_age.present?

    products = products.where(color_white: color_white) if color_white.present?
    products = products.where(color_black: color_black) if color_black.present?
    products = products.where(color_red: color_red) if color_red.present?
    products = products.where(color_yellow: color_yellow) if color_yellow.present?
    products = products.where(color_green: color_green) if color_green.present?
    products = products.where(color_blue: color_blue) if color_blue.present?
    products = products.where(color_violet: color_violet) if color_violet.present?

    products = products.where(material_plastic: material_plastic) if material_plastic.present?
    products = products.where(material_wooden: material_wooden) if material_wooden.present?
    products = products.where(material_another: material_another) if material_another.present?
    products = products.where(material_iron: material_iron) if material_iron.present?
    products = products.where(material_fabric: material_fabric) if material_fabric.present?
    products = products.where(material_mixed: mixed) if material_mixed.present?
    products
  end
end
