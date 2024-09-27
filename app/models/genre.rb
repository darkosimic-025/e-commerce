class Genre < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  def self.ransackable_associations(auth_object = nil)
    ["books"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name id]
  end
end
