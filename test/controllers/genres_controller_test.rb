require "test_helper"

class GenresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @admin = admins(:admin_one)
    sign_in @admin
  end

  test "should create genre" do
    assert_difference('Genre.count', 1) do
      post genres_url, params: { genre: { name: "Test Genre", description: "A great genre" } }
    end
    assert_redirected_to genre_path(Genre.last)
  end

  test "should destroy genre" do
    genre = genres(:genre_one)
    assert_difference('Genre.count', -1) do
      delete genre_url(genre)
    end
    assert_redirected_to genres_path
  end
end

