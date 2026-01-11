ActiveAdmin.register Tour do
  permit_params :name, :status, :actif, :user_id

  menu label: "Tours", parent: "Event", priority: 0
  # menu false
  config.batch_actions = false

  includes :events

  action_item "Close", only: [ :show ] do
    link_to "Close", admin_tours_path
  end

  filter :name_cont, as: :string, label: "Name"

  index do
    column "Name" do |tour|
      link_to tour.name, admin_tour_path(tour), method: :get
    end
    column "Year" do |tour|
      tour.year
    end
    column "Status" do |tour|
      tour.status
    end
    column "" do |tour|
      button_to "Edit", edit_admin_tour_path(tour), method: :get, class: "btn-edit"
    end
  end

  form do |f|
    f.inputs "Tour" do
      f.input :name
      f.input :status, as: :select, collection: Tour.statuses.keys
      f.input :actif
      f.input :year
    end
    f.actions do
       f.action :submit
       f.cancel_link(url_for(:back))
    end
  end

  show do
    default_main_content

    div do
      button_to "Add event", new_admin_tour_event_path(tour_id: resource.id), method: :get
    end

    panel "Events" do
      table_for tour.events do
        column "Name" do |event|
          link_to event.name, admin_tour_event_path(tour, event), method: :get
        end
        column "Format", :format
        column "Status" do |event|
          event.status
        end
        column "Playercats" do |event|
          event.playercats.map(&:name).join(", ")
        end
        column "" do |event|
          button_to "Edit", edit_admin_tour_event_path(tour, event), method: :get, class: "btn-edit"
        end
      end
    end
  end
end
