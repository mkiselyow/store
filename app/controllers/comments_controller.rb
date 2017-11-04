class CommentsController < ApplicationController
  def index
    @comment = Comment.new
    @comments = Comment.all
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :rating)
  end
end
