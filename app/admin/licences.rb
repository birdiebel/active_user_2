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

  includes :player
  actions :index, :show
  filter :player_lastname, :as => :string
  filter :num

  index do
    column :id
    column :player, sortable: 'player.lastname'
    column :num
    column :hcp
    column :club
    actions
  end

  show do 
    attributes_table_for(resource) do 
      row :num
      row :hcp
      row :club
      row :created_at
      row :updated_at
    end
    panel "Player" do
      attributes_table_for(resource.player) do 
        row :lastname
        row :firstname
        row :dob
        row :sexe
        row :lang
      end

      if resource.player.user
        attributes_table_for(resource.player.user) do
          row :email
        end
      end

    end
  end
    
end
