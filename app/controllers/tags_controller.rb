class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find_by(name: params[:name])
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to tags_path
    else
      render "new"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :color)
  end
end
