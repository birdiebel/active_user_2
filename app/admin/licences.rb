ActiveAdmin.register Licence do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :player_id, :num, :hcp, :club, :actif
  #
  # or
  #
  # permit_params do
  #   permitted = [:player_id, :num, :hcp, :club, :actif]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  belongs_to :player
  includes :player
  filter :player_lastname, :as => :string
  filter :num
  menu false

  action_item 'Close', only: [:show] do
    link_to 'Close', admin_player_path(resource.player)
  end

  index do
    column :id
    column :player, sortable: 'player.lastname'
    column :num
    column :hcp
    column :club
    actions
  end

  form do |f|
    f.inputs "Licence" do
      # f.input :player
      f.input :num
      f.input :hcp
      f.input :club
      f.input :actif
    end
    f.actions do
       f.action :submit
       f.cancel_link(url_for(:back))
    end   
  end

  show :title => proc {|licence| "Licence : "+licence.player.full_name} do 
    panel "Licence" do
      attributes_table_for(resource) do 
        row :num
        row :hcp
        row :club
        row :created_at
        row :updated_at
      end
    end
  end
    
end
