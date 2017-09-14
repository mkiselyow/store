class AddTimesviewedColumnToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :times_viewed, :integer
  end
end
