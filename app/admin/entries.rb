ActiveAdmin.register Entry do
  permit_params :event_id, :player_id, :licence_id, :status

  includes :event, :player, :licence
  config.batch_actions = false

  index do
    div do
        button_to "Add Player", admin_add_entry_path(event_id: 1), method: :get
    end

    table_for Entry.order("created_at DESC") do
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



    # table_for Player.all do |player|
    #     column :id
    #     column :full_name do |player|
    #         player.full_name
    #     end
    #     column :my_licence do |player|
    #         player.my_licence
    #     end
    #     column :my_club do |player|
    #         player.my_club
    #     end
    #     column :age do |player|
    #         player.age
    #     end
    #     column "Cat" do |player|
    #         player.age_category
    #     end
    # end
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
