class Order < ApplicationRecord
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    %w[id total_amount created_at updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

end
