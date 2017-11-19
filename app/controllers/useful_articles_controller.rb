class UsefulArticlesController < ApplicationController
  def index
    @useful_articles = UsefulArticle.where(published: true)
  end

  def show
    @useful_article = UsefulArticle.find(params[:id])
  end
end
