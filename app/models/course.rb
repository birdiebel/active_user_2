class Course < ApplicationRecord
  
  belongs_to :club

  def self.ransackable_attributes(auth_object = nil)
    ["club_id", "created_at", "id", "name", "updated_at", "version"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["club"]
  end

end
