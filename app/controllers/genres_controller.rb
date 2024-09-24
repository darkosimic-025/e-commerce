class GenresController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      respond_to do |format|
        format.html { redirect_to @genre, notice: 'Genre was successfully created.' }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def delete
    @genre = Genre.find(params[:id])
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    respond_to do |format|
      format.html { redirect_to genres_path, notice: 'Genre was successfully deleted.' }
      format.turbo_stream
    end
  end


  private

  def genre_params
    params.require(:genre).permit(:name, :description)
  end
end
