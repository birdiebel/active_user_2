class Event < ApplicationRecord
  belongs_to :tour

  def self.ransackable_associations(auth_object = nil)
    [ "tour" ]
  end
  def self.ransackable_attributes(auth_object = nil)
    [ "actif", "created_at", "id", "name", "status", "tour_id", "updated_at" ]
  end

  enum :status, [ :created, :online, :registration, :waiting, :running, :terminated, :canceled ]
end
