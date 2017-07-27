class AddColumnToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :image_id, :string
  end
end
