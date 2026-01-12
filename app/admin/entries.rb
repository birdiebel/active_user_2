ActiveAdmin.register Entry do
  permit_params :event_id, :player_id, :licence_id, :status

  index do
    selectable_column
    column :event
    column :player do |entry|
      entry.player.full_name
    end
    column :licence do |entry|
      if entry.licence
        "#{entry.licence.num} (#{entry.licence.club})"
      else
        "N/A"
      end
    end
    column :status
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :event
      f.input :player, collection: Player.order("lastname ASC").all.map { |p| [ p.full_name, p.id ] }
      if !f.object.new_record?
        f.input :licence, collection: Licence.where(player_id: f.object.player_id).order("num ASC").all.map { |l| [ "#{l.num} (#{l.club})", l.id ] }
      end
      f.input :status
    end
    f.actions
  end
end
