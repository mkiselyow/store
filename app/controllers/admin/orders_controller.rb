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

  def all_orders_delivered
    Order.all.update_all(delivered: true)
    redirect_back(fallback_location: admin_orders_path)
  end

  private

  def order_resourses
    @order = Order.find(params[:id])
  end
end
