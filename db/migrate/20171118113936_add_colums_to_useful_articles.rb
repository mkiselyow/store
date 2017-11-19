class AddColumsToUsefulArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :useful_articles, :published, :boolean, default: false
    add_column :useful_articles, :category_id, :integer
  end
end
