class Entry < ApplicationRecord
  belongs_to :event
  belongs_to :player
  belongs_to :licence, optional: true

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "event_id", "id", "licence_id", "player_id", "status", "updated_at" ]
  end
  def self.ransackable_associations(auth_object = nil)
    [ "event", "player" ]
  end

  enum :status, [ :created, :confirmed, :paid, :canceled ]

  after_save :add_licence_to_entry

  def add_licence_to_entry
    if self.licence_id.nil?
      lic = self.player.licences.first
      if lic
        self.update_column(:licence_id, lic.id)
      end
    end
  end
end
