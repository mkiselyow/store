class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.string :title
      t.text :body
      t.string :poster
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
