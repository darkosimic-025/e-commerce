class Book < ApplicationRecord
  belongs_to :genre
  validates :title, :author, :price, presence: true
  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[title author price published_date genre_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[genre]
  end

end
