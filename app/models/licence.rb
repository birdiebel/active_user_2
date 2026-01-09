class Licence < ApplicationRecor
  def self.ransackable_attributes(auth_object = nil)
    [ "actif", "club", "created_at", "hcp", "id", "num", "player_id", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "player" ]
  end

  belongs_to :player
  validates :num, presence: true
end
