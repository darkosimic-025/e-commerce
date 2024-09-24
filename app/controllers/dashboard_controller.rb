class DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
  end
  def books
    @books = Book.all
  end
  def genres
    @genres = Genre.order(created_at: :desc)
  end
end
