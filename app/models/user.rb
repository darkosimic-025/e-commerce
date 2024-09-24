class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.ransackable_attributes(auth_object = nil)
    ["email"]
  end

end
