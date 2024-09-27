class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]
  before_action :authenticate_admin!

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      respond_to do |format|
        format.html { redirect_to admin_dashboard_books_path, notice: 'Book was successfully created.' }
        format.turbo_stream
      end
    else
      render :new
    end
  end


  def delete
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to admin_dashboard_books_path, notice: 'Book was successfully deleted.' }
      format.turbo_stream
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :price, :description, :published_date, :isbn, :stock_quantity, :genre_id)
  end
end
