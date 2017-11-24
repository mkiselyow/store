class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.string :title
      t.text :body
      t.string :poster
      t.belongs_to :user, foreign_key: true
      t.date :start_share
      t.date :end_share

      t.timestamps
    end
  end
end
