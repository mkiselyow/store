class Admin::OrdersController < AdminsController
  def index
    @orders = Order.order(:id)
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy!
    redirect_back(fallback_location: admin_root_path, notice: 'Заказ удалён')
  end
end
