class AddColumsToProduct < ActiveRecord::Migration[5.1]
  def up
    add_column :products, :min_age, :integer
    add_column :products, :max_age, :integer
    add_column :products, :sex_id, :integer
  end

  def down
    add_column :products, :boys, :boolean
    add_column :products, :girls, :boolean
  end
end
