class Agecat < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "age_high", "age_low", "color", "created_at", "id", "name", "short", "updated_at", "year" ]
  end
  has_many :playercats
end
