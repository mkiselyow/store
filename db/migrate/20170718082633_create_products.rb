class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string  :title
      t.integer :size_a
      t.integer :size_b
      t.integer :size_h
      t.integer :purchase_price
      t.integer :mark_up
      t.integer :price
      t.integer :weight
      t.boolean :color_white
      t.boolean :color_black
      t.boolean :color_red
      t.boolean :color_yellow
      t.boolean :color_green
      t.boolean :color_blue
      t.boolean :color_violet
      t.string  :brand
      t.boolean :material_plastic
      t.boolean :material_iron
      t.boolean :material_another
      t.boolean :material_wooden
      t.boolean :material_fabric
      t.string  :supplier
      t.integer :quantity

      t.timestamps
    end
  end
end
