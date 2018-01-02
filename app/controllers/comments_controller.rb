class CommentsController < ApplicationController
  before_action :comment_resourse, only: %i[edit update destroy]

  def index
    @comment = Comment.new
    @comments = Comment.order(:id).paginate(page: params[:page], per_page: 10)
  end

  def create
    @comment = current_user.comments.create(comment_params)
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
  end

  def update
    @comment.update(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :rating)
  end

  def comment_resourse
    @comment = Comment.find(params[:id])
  end
end
