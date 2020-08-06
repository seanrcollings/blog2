class PostsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, except: [:index, :show, :recent, :search]

  def index
    @posts = Post.order(id: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.add_tags params[:tags]

    if @post.save
      redirect_to @post
    else
      render "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.add_tags params[:tags]

    if @post.update(post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def recent
    @post = Post.order(updated_at: :desc).first
    if not @post
      redirect_to about_path
    end
  end

  def search
    if params[:q] and params[:q].length > 0
      @param = params[:q].downcase
      @posts = Post.all.where("lower(title) LIKE :search", search: "%#{@param}%")
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :tldr)
  end
end
