class AddMixedToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :mixed, :boolean
  end
end
