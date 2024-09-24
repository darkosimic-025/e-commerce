class Book < ApplicationRecord
  belongs_to :genre
  validates :title, :author, :price, presence: true
end
