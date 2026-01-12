ActiveAdmin.register Entry do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :event_id, :player_id, :licence_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:event_id, :player_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    column :event do |entry|
      entry.event.name
    end
    column :player do |entry|
      entry.player.full_name
    end
    column :licence do |entry|
      if entry.licence
        "#{entry.licence.num} (#{entry.licence.club})"
      else
        "-"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :event, as: :select, collection: Event.all.collect { |event| [ event.name, event.id ] }, include_blank: false
      f.input :player, as: :select, collection: Player.order("lastname ASC").all.collect { |player| [ player.full_name, player.id ] }, include_blank: false
      if !f.object.new_record?
        f.input :licence, as: :select, collection: Licence.where(player_id: f.object.player_id).collect { |licence| [ "#{licence.num} (#{licence.club})", licence.id ] }, include_blank: true
      end
    end
    f.actions
  end
end
