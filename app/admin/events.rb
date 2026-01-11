ActiveAdmin.register Event do
  permit_params :name, :status, :actif, :tour_id
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
    column "" do |event|
      button_to "Edit", edit_admin_tour_event_path(event.tour, event), method: :get, class: "btn-edit"
    end
  end

  show title: myTitle do
    default_main_content
  end
end
