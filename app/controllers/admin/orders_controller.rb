class Admin::OrdersController < AdminsController
  def index
    @orders = Order.order(:id)
  end
end
