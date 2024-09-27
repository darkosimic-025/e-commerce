class AddCascadingDeleteToCartItems < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :cart_items, :books

    add_foreign_key :cart_items, :books, on_delete: :cascade
  end
end
