class CommentsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.post = @post
    @comment.user = current_user
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
