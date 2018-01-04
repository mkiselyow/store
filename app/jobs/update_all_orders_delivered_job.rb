class UpdateAllOrdersDeliveredJob < ApplicationJob
  queue_as :default

  def perform(*args)
    orders = Order.all
    orders.update_all(delivered: true)
  end
end
