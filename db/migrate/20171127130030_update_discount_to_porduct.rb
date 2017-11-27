class UpdateDiscountToPorduct < ActiveRecord::Migration[5.1]
  def up
    change_column :products, :discount, :integer, default: 0
  end

  def down
    change_column :products, :discount, :integer
  end
end
