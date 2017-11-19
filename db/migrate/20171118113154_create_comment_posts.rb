class CreateCommentPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :comment_posts do |t|
      t.text :body
      t.belongs_to :user, foreign_key: true
      t.belongs_to :useful_article, foreign_key: true

      t.timestamps
    end
  end
end
