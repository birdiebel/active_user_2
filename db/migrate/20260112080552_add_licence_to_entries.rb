class AddLicenceToEntries < ActiveRecord::Migration[8.1]
  def change
    add_reference :entries, :licence, foreign_key: true
  end
end
