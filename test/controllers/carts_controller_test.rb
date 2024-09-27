require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = admins(:admin_one)
    @user = users(:user_one)
    @book = books(:book_one)
    log_in_as(@user)
  end

  test "should add book to cart" do
    session[:cart] = []

    assert_difference('session[:cart].length', 1) do
      post add_carts_url, params: { book_id: @book.id }
    end
    assert_redirected_to root_path
  end

  test "should remove book from cart" do
    session[:cart] = [@book.id]

    assert_difference('session[:cart].length', -1) do
      delete remove_carts_url, params: { book_id: @book.id }
    end
    assert_redirected_to root_path
  end

  test "should update quantity of book in cart" do
    session[:cart] = [@book.id]
    session[:cart_quantities] = { @book.id.to_s => 1 }

    post update_quantity_carts_url, params: { book_id: @book.id, quantity: 2 }

    assert_equal 2, session[:cart_quantities][@book.id.to_s]
    assert_redirected_to root_path
  end
end
