class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :permit_ransack_params, only: [:index]
  before_action :set_cart, only: [:index]


  def index
    puts params
    @q = Book.ransack(params[:q])
    @genres = Genre.all
    @books = @q.result(distinct: true).includes(:genre.name).paginate(page: params[:page], per_page: 8)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def permit_ransack_params
    params[:q] = {} unless params[:q].present?
    params[:q].permit!
  end

  def set_cart
    @cart = session[:cart] || []
    @cart_quantities = session[:cart_quantities] || {}

    @cart_items = @cart.map do |book_id|
      book = Book.find(book_id)
      quantity = @cart_quantities[book_id.to_s] || 1
      { book: book, quantity: quantity }
    end
  end
end
