class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart, dependent: :destroy
  def self.ransackable_attributes(auth_object = nil)
    ["email"]
  end

end
