class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :number
      t.text :comment
      t.string :city
      t.integer :post_office_number
      t.string :pay_type

      t.timestamps
    end
  end
end
