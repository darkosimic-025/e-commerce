class Book < ApplicationRecord
  belongs_to :genre
  validates :title, presence: true
  validates :author, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :published_date, presence: true
  validates :isbn, presence: true
  validates :stock_quantity, presence: true, numericality: { only_integer: true }
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[title author price published_date genre_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[genre]
  end

end
