class UpdateColumnCodeToProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :product_code, :integer
  end
end
