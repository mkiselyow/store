class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :title
      t.string :product_code
      t.integer :category_id
      t.integer :min_age
      t.integer :max_age
      t.integer :sex_id
      t.decimal :min_price
      t.decimal :max_price
      t.string :brand
      t.boolean :color_white
      t.boolean :color_black
      t.boolean :color_red
      t.boolean :color_yellow
      t.boolean :color_green
      t.boolean :color_blue
      t.boolean :color_violet
      t.boolean :material_plastic
      t.boolean :material_iron
      t.boolean :material_another
      t.boolean :material_wooden
      t.boolean :material_fabric
      t.boolean :material_mixed

      t.timestamps
    end
  end
end
