class AddOtherDescToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :other_desc, :string
  end
end
