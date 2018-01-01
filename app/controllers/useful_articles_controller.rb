class UsefulArticlesController < ApplicationController
  def index
    @useful_articles = UsefulArticle.only_published
  end

  def show
    @useful_article = UsefulArticle.find(params[:id])
    @comment_posts = @useful_article.comment_posts
  end
end
