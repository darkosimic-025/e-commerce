require "test_helper"

class GenreTest < ActiveSupport::TestCase
  def setup
    @genre = Genre.new(
      name: "Fiction 2",
      description: "A literary genre that includes fictional stories."
    )
  end

  test "should be valid" do
    assert @genre.valid?
  end

  test "name should be present" do
    @genre.name = ""
    assert_not @genre.valid?
  end

  test "description should be present" do
    @genre.description = ""
    assert_not @genre.valid?
  end

  test "should save valid genre" do
    assert @genre.save
  end

  test "name should be unique" do
    @genre.save
    duplicate_genre = @genre.dup
    duplicate_genre.name = @genre.name.upcase
    assert_not duplicate_genre.valid?
  end
end
