class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def books
    @q = Book.ransack(params[:q])
    @books = @q.result.includes(:genre).page(params[:page]).per(10)
  end

  def genres
    @q = Genre.ransack(params[:q])
    @genres = @q.result.page(params[:page]).per(10)
  end

  def users
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(10)
  end
end
