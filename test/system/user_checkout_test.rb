require "application_system_test_case"

class UserCheckoutTest < ApplicationSystemTestCase
  setup do
    @user = users(:user_one)
    @book1 = books(:book_one)
    @book2 = books(:book_two)
  end

  test "user can register, add items to cart and checkout with Stripe" do
    # Step 1: User registers
    visit new_user_registration_path
    fill_in "Your email", with: "testuser@example.com"
    fill_in "Password", with: "password123"
    fill_in "Confirm password", with: "password123"
    click_on "Create an account"

    assert_text "Welcome! You have signed up successfully."

    visit root_path

    add_book_to_cart(@book1)

    add_book_to_cart(@book2)

    find("#cart_dropdown_button").click
    click_on "Proceed to Checkout"

    assert_text "Checkout with Stripe"
  end

  private

  def add_book_to_cart(book)
    within("h3", text: book.title) do
      find(:xpath, "..").find("form.button_to").click_button("Add to cart")
    end
  end
end
