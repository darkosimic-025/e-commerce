class OrdersController < ApplicationController
  def success
    order = Order.create(user: current_user, total_amount: calculate_total)

    session[:cart] = []
    session[:cart_quantities] = {}

    redirect_to root_path, notice: 'Order created successfully!'
  end

  def cancel
    redirect_to root_path, alert: 'Payment canceled.'
  end

  private

  def calculate_total
    cart_items = session[:cart].map { |book_id| Book.find(book_id) }
    cart_items.sum { |book| book.price * (session[:cart_quantities][book.id.to_s] || 1) }
  end
end
