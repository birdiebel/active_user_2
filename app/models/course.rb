class Course < ApplicationRecord
  
  belongs_to :club
  has_many :tees

  def self.ransackable_attributes(auth_object = nil)
    ["club_id", "created_at", "id", "name", "updated_at", "version"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["club"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tees"]
  end

  accepts_nested_attributes_for :tees

end
