class CreateUsefulArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :useful_articles do |t|
      t.string :title
      t.text :body
      t.string :preview
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
