class AddColumnsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :boys, :boolean
    add_column :products, :girls, :boolean
  end
end
