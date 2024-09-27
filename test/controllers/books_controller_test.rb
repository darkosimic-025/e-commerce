require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = admins(:admin_one) # Ensure this fixture exists for admin
    sign_in @admin
  end

  test "should create book" do
    genre = genres(:genre_one)
    assert_difference('Book.count', 1) do
      post books_url, params: { book: {
        title: "Test Book",
        author: "Author Name",
        price: 20.0,
        description: "A great book",
        published_date: "2023-01-01",
        isbn: "1234567890",
        stock_quantity: 10,
        genre_id: genre.id
      } }
    end
    assert_redirected_to admin_dashboard_books_path
  end



  test "should destroy book" do
    book = books(:book_one)
    assert_difference('Book.count', -1) do
      delete book_url(book)
    end
    assert_redirected_to admin_dashboard_books_url
  end
end
