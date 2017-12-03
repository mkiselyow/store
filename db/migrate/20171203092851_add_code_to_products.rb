class AddCodeToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :product_code, :string
  end
end
