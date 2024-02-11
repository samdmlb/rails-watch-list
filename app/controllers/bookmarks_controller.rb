class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[destroy]

  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(params_bookmark)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def params_bookmark
    params.require(:bookmark).permit(:comment, :movie_id, :list_id)
  end
end
