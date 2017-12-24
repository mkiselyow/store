class Admin::OrdersController < AdminsController
  before_action :order_resourses, only: [:destroy, :order_delivered]

  def index
    @orders = Order.order(:id)
  end

  def destroy
    @order.destroy!
  end

  def order_delivered
    @order.update(delivered: !@order.delivered)
  end

  private

  def order_resourses
    @order = Order.find(params[:id])
  end
end
