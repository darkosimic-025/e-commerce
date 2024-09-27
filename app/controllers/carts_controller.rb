class CartsController < ApplicationController
  before_action :set_cart

  def checkout
    @cart_items = session[:cart] || []
    @cart_items = @cart_items.map do |book_id|
      book = Book.find(book_id)
      quantity = session[:cart_quantities] ? session[:cart_quantities][book_id.to_s] || 1 : 1
      { book: book, quantity: quantity }
    end
  end

  def create_order
    @order = Order.new(user: current_user, total_amount: @cart_items.sum { |item| item[:book].price * item[:quantity] })

    if @order.save
      # Clear cart and quantities
      session[:cart] = []
      session[:cart_quantities] = {}

      # You may want to create an OrderItem model if you want to keep track of which books were purchased
      @cart_items.each do |item|
        OrderItem.create(order: @order, book: item[:book], quantity: item[:quantity])
      end

      redirect_to root_path, notice: 'Order created successfully!'
    else
      render :checkout, alert: 'There was an error creating your order.'
    end
  end

  def add
    book = Book.find(params[:book_id])
    @cart << book.id unless @cart.include?(book.id)
    session[:cart] = @cart

    set_cart
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("cart_button_#{book.id}", partial: "home/cart_button", locals: { book: book, cart: @cart }),
          turbo_stream.prepend("cart_dropdown", partial: "shared/cart_dropdown_item", locals: { book: book, quantity: 1 }),
          turbo_stream.replace("cart_dropdown_footer", partial: "shared/cart_dropdown_footer", locals: { cart_items: @cart_items })
        ]
      end
      format.html { redirect_to root_path, notice: 'Book added to cart' }
    end
  end


  def remove
    book = Book.find(params[:book_id])
    @cart.delete(book.id)
    session[:cart_quantities].delete(book.id.to_s) if session[:cart_quantities]
    session[:cart] = @cart

    set_cart
    puts "Cart items after removal: #{@cart_items.inspect}"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update("cart_button_#{book.id}", partial: "home/cart_button", locals: { book: book, cart: @cart }),
          turbo_stream.remove("cart_item_#{book.id}"),
          turbo_stream.update("order_summary", partial: "carts/order_summary", locals: { cart_items: @cart_items }),
          turbo_stream.remove("cart_dropdown_item_#{book.id}"),
          turbo_stream.replace("cart_dropdown_footer", partial: "shared/cart_dropdown_footer", locals: { cart_items: @cart_items })
        ]
      end
    end
  end


  def update_quantity
    book = Book.find(params[:book_id])
    quantity = params[:quantity].to_i

    session[:cart_quantities] ||= {}
    session[:cart_quantities][book.id.to_s] = quantity

    set_cart
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("cart_item_#{book.id}", partial: "carts/cart_item", locals: { book: book, quantity: quantity }),
          turbo_stream.update("order_summary", partial: "carts/order_summary", locals: { cart_items: @cart_items }),
          turbo_stream.replace("cart_dropdown_item_#{book.id}", partial: "shared/cart_dropdown_item", locals: { book: book, quantity: quantity }),
          turbo_stream.replace("cart_dropdown_footer", partial: "shared/cart_dropdown_footer", locals: { cart_items: @cart_items })
        ]
      end
    end
  end


  private

  def set_cart
    session[:cart_quantities] ||= {}
    @cart = session[:cart] || []
    @cart_items = @cart.map do |book_id|
      { book: Book.find(book_id), quantity: session[:cart_quantities][book_id.to_s] || 1 }
    end
  end
end
