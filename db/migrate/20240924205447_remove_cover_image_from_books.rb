class RemoveCoverImageFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :cover_image, :string
  end
end
