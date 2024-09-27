require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(
      title: "Test Book",
      author: "Author Name",
      price: 20.0,
      description: "A great book",
      published_date: "2023-01-01",
      isbn: "1234567890",
      stock_quantity: 10,
      genre: genres(:genre_one) # Ensure this fixture exists
    )
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = ""
    assert_not @book.valid?
  end

  test "author should be present" do
    @book.author = ""
    assert_not @book.valid?
  end

  test "price should be present" do
    @book.price = nil
    assert_not @book.valid?
  end

  test "price should be greater than or equal to 0" do
    @book.price = -1
    assert_not @book.valid?
  end

  test "isbn should be present" do
    @book.isbn = ""
    assert_not @book.valid?
  end

  test "stock_quantity should be present" do
    @book.stock_quantity = nil
    assert_not @book.valid?
  end

  test "stock_quantity should be an integer" do
    @book.stock_quantity = 5.5
    assert_not @book.valid?
  end

  test "should save valid book" do
    assert @book.save
  end

  test "should not save book without genre" do
    @book.genre = nil
    assert_not @book.save
  end
end
