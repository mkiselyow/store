class AddNewColumnsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :country, :string
    add_column :products, :discount, :integer
    add_column :products, :product_code, :integer
  end
end
