class Playercat < ApplicationRecord
  belongs_to :agecat
  has_and_belongs_to_many :events

  def self.ransackable_attributes(auth_object = nil)
    [ "agecat_id", "created_at", "hcp_max", "hcp_min", "id",
      "name", "teebox", "updated_at", "version", "sexe", "priority", "actif", "format" ]
  end
  def self.ransackable_associations(auth_object = nil)
    [  "agecat" ]
  end

  enum :sexe, [ :Men, :Ladies ]
  enum :teebox, [ "Black", "White", "Yellow", "Blue", "Red" ]
  enum :format, [ :single, :team ]
end
