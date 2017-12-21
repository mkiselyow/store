class Admin::OrdersController < AdminsController
  before_action :order_resourses, only: [:destroy, :order_delivered]

  def index
    @orders = Order.order(:id)
  end

  def destroy
    @order.destroy!
    redirect_back(fallback_location: admin_root_path, notice: 'Заказ удалён')
  end

  def order_delivered
    @order.update(delivered: !@order.delivered)
    redirect_back(fallback_location: admin_orders_path, notice: 'Статус заказа был успешно изменён')
  end

  private

  def order_resourses
    @order = Order.find(params[:id])
  end
end
