class Entry < ApplicationRecord
  belongs_to :event
  belongs_to :player
  belongs_to :licence, optional: true

  def self.ransackable_associations(auth_object = nil)
    [ "event", "player" ]
  end
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "event_id", "id", "player_id", "updated_at", "licence_id" ]
  end

  after_save :save_first_licence

  def save_first_licence
    puts "enter save_first_licence"
    if self.licence.nil?
      if self.player && self.player.licences.any?
          puts "no licence for player #{self.player.full_name}"
          self.licence = self.player.licences.first
          self.update_column(:licence_id, self.licence.id)
      end
    end
  end
end
