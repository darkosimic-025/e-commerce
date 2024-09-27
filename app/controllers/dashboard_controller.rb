class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def books
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:genre.name).paginate(page: params[:page], per_page: 10)
  end

  def genres
    @q = Genre.ransack(params[:q])
    @genres = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def users
    @q = User.ransack(params[:q])
    @users = @q.result.page(params[:page]).paginate(page: params[:page], per_page: 10)
  end

  def orders
    @q = Order.ransack(params[:q])
    @orders = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end
end
