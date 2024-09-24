class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price
      t.text :description
      t.date :published_date
      t.string :isbn
      t.integer :stock_quantity
      t.string :cover_image
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
