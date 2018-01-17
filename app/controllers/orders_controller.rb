class OrdersController < ApplicationController
  def new
    if @cart.line_items.empty?
      redirect_to root_url, notice: t('message.your_cart_empty')
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
        @order.line_items.each do |line_item|
          line_item.update(cart_id: @cart.id)
        end
        session[:cart_id] = nil
        OrderNotifierMailer.recieved(@order).deliver
        OrderNotifierMailer.user_order_recieved(@order).deliver
        format.html { redirect_to root_url, notice: t('message.order_in_treatment') }
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
