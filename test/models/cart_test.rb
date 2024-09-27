require "test_helper"

class CartTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)
    @cart = carts(:cart_one)
  end

  test "should be valid with a user" do
    assert @cart.valid?
  end

  test "should require a user" do
    @cart.user = nil
    assert_not @cart.valid?
  end

  test "should create a cart" do
    assert_difference('Cart.count', 1) do
      new_cart = Cart.create(user: users(:user_three))
      assert new_cart.valid?, new_cart.errors.full_messages.to_sentence
    end
  end

  test "should not allow duplicate carts for the same user" do
    @cart.save
    duplicate_cart = Cart.new(user: @user)
    assert_not duplicate_cart.valid?
  end
end
