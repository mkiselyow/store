class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.all
  end

  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: 'Корзина пока пуста'
      return
    end
    @order = Order.new
  end

  def create
    address_array = params[:order][:city]
    address_string = address_array[:area] + ', ' + address_array[:region] + ', ' + address_array[:city]
    params[:order][:city] = address_string
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        @order.add_line_items_from_cart(@cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifierMailer.recieved(@order).deliver
        format.html { redirect_to root_url, notice: 'Ваш заказ отправлен в обработку' }
        format.json { render :show, status: :created, location: @order }
      else
        # @cart = current_cart
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :number, :comment, :city, :post_office_number, :pay_type)
  end
end
