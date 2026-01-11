ActiveAdmin.register Event do
  permit_params :name, :status, :actif, :tour_id, :format, playercat_ids: []
  belongs_to :tour
  includes :tour

  # menu false
  # menu label: "Events", parent: "Event", priority: 1
  menu false
  config.batch_actions = false

  action_item "Close", only: [ :show ] do
    link_to "Close", admin_tour_path(resource.tour_id)
  end

  myTitle = proc { |event| "#{event.tour.name} : #{event.name}" }
  filter :name_cont, as: :string, label: "Name"



  index do
    column "Name" do |event|
      link_to event.name, admin_tour_event_path(event.tour, event), method: :get
    end
    column "Status" do |event|
      event.status
    end
    column "Playercats" do |event|
      event.playercats.map(&:name).join(", ")
    end
    column "" do |event|
      button_to "Edit", edit_admin_tour_event_path(event.tour, event), method: :get, class: "btn-edit"
    end
  end

  show title: myTitle do
    default_main_content
    panel "Player Categories" do
      table_for event.playercats do |playercat|
          column "name", :name
          column "format", :format
          column "sexe", :sexe
          column "teebox", :teebox
          column "hcp_min", :hcp_min
          column "hcp_max", :hcp_max
      end
    end
  end

  form do |f|
    f.inputs "Event Details" do
      f.input :tour, as: :select, collection: Tour.all.collect { |tour| [ tour.name, tour.id ] }, include_blank: false
      f.input :name
      f.input :format, as: :select, collection: Event.formats.keys
      f.input :status, as: :select, collection: Event.statuses.keys
      f.input :actif
      f.input :playercats, as: :check_boxes, collection: Playercat.all.map { |pc| [ pc.name, pc.id ] }
    end
    f.actions do
      f.action :submit
      f.cancel_link(url_for(:back))
    end
  end
end
