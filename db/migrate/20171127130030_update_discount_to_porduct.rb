class UpdateDiscountToPorduct < ActiveRecord::Migration[5.1]
  def up
    change_column :products, :discount, :integer, default: 0
    change_column :products, :mark_up, :integer, default: 0
  end

  def down
    change_column :products, :discount, :integer
    change_column :products, :mark_up, :integer
  end
end
