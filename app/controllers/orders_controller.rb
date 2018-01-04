class OrdersController < ApplicationController
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: 'Корзина пока пуста'
      return
    end
    @order = Order.new
  end

  def create
    address_array = params[:order][:city]
    address_string = address_array[:area] + ', ' + address_array[:city]
    params[:order][:city] = address_string
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        @order.add_line_items_from_cart(@cart)
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifierMailer.recieved(@order).deliver
        OrderNotifierMailer.user_order_recieved(@order).deliver
        format.html { redirect_to root_url, notice: 'Ваш заказ отправлен в обработку' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :number, :comment, :city,
                                  :post_office_number, :pay_type, :way_delivery, :user_id)
  end
end
