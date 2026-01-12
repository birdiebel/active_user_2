class Event < ApplicationRecord
  belongs_to :tour
  has_and_belongs_to_many :playercats
  has_many :entries, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    [ "tour" ]
  end
  def self.ransackable_attributes(auth_object = nil)
    [ "actif", "created_at", "id", "name", "status", "tour_id", "updated_at", "format" ]
  end

  enum :status, [ :created, :online, :registration, :waiting, :running, :terminated, :canceled ]
  enum :format, [ :single, :team ]
end
