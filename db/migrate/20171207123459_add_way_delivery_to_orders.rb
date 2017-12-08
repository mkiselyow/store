class AddWayDeliveryToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :way_delivery, :string
  end
end
