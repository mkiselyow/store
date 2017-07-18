class ChangeColumnsInProducts < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :price, :decimal, precision: 8, scale: 2
    change_column :products, :purchase_price, :decimal, precision: 8, scale: 2, precision: 8, scale: 2
    change_column :products, :weight, :decimal, precision: 8, scale: 2, precision: 8, scale: 2, precision: 8, scale: 2
  end
end
