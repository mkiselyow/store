require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { brand: @product.brand, color_black: @product.color_black, color_blue: @product.color_blue, color_green: @product.color_green, color_red: @product.color_red, color_violet: @product.color_violet, color_white: @product.color_white, color_yellow: @product.color_yellow, mark_up: @product.mark_up, material_another: @product.material_another, material_fabric: @product.material_fabric, material_iron: @product.material_iron, material_plastic: @product.material_plastic, material_wooden: @product.material_wooden, price: @product.price, purchase_price: @product.purchase_price, quantity: @product.quantity, size_a: @product.size_a, size_b: @product.size_b, size_h: @product.size_h, supplier: @product.supplier, title: @product.title, weight: @product.weight } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { brand: @product.brand, color_black: @product.color_black, color_blue: @product.color_blue, color_green: @product.color_green, color_red: @product.color_red, color_violet: @product.color_violet, color_white: @product.color_white, color_yellow: @product.color_yellow, mark_up: @product.mark_up, material_another: @product.material_another, material_fabric: @product.material_fabric, material_iron: @product.material_iron, material_plastic: @product.material_plastic, material_wooden: @product.material_wooden, price: @product.price, purchase_price: @product.purchase_price, quantity: @product.quantity, size_a: @product.size_a, size_b: @product.size_b, size_h: @product.size_h, supplier: @product.supplier, title: @product.title, weight: @product.weight } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
