class CreateImageProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :image_products do |t|
      t.string :image
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
