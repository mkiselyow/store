class PagesController < ApplicationController
  def payment_and_delivery; end

  def useful_articles
  	@useful_articles = UsefulArticle.all
  end

  def special_offers; end

  def contacts; end

  def about; end

  def competitions; end

  def partners; end
end
