class TagsController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by(name: params[:name])
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find_by(name: params[:name])
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path
    else
      render "new"
    end
  end

  def update
    @tag = Tag.find_by(name: params[:name])

    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render "new"
    end
  end

  def search
    if params[:q] and params[:q].length > 0
      @param = params[:q].downcase
      @tags = Tag.all.where("lower(name) LIKE :search", search: "%#{@param}%")
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :color)
  end
end
