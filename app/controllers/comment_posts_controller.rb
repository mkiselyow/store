class CommentPostsController < ApplicationController
  before_action :articles_resource
  before_action :comment_resource, only: :destroy

  def create
    @comment_post = @useful_article.comment_posts.create(comment_params)
    @comment_post.user_id = current_user.id
    @comment_post.save
    redirect_back(fallback_location: useful_article_path(@useful_article), notice: 'Комментарий был опубликован')
  end

  def destroy
    @comment_post.destroy!
    redirect_back(fallback_location: useful_article_path(@useful_article), notice: 'Комментарий был удалён')
  end

  private

  def articles_resource
    @useful_article = UsefulArticle.find(params[:useful_article_id])
  end

  def comment_resource
    @comment_post = @useful_article.comment_posts.find(params[:id])
  end

  def comment_params
    params.require(:comment_post).permit(:body, :user_id)
  end
end
