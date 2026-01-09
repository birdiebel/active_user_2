ActiveAdmin.register Player do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :firstname, :lastname, :dob, :sexe, :lang, :user_id,
                licences_attributes: [:id, :num, :hcp, :club],
                user_attributes: [:id, :email, :actif, :role, :password, :password_confirmation, :encrypted_password]

  #
  # or
  #
  # permit_params do
  #   permitted = [:firstname, :lastname, :dob, :sexe, :lang, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  belongs_to :user, optional: true
  includes :user, :licences

  filter :lastname_cont, as: :string, label: "Name"
  filter :user_email_cont, as: :string, label: "Email"
  filter :licences_num_cont, as: :string, label: "Licence"

  config.sort_order = 'lastname_asc'

  scope :all

  action_item 'Close', only: [:show] do
    link_to 'Close', admin_players_path
  end

  # action_item 'Close', only: [:edit] do
  #   link_to 'Close', admin_player_path(resource.id)
  # end

  index do 
    selectable_column
    column :full_name
    column "User", :my_user
    column "Licences", :my_licence    
    actions
  end

  form do |f|
    f.inputs 'Player informations' do
      # f.input :user_id, label: 'User', as: :select, collection: User.all.map { |u| ["#{u.id}, #{u.email}", u.id] }   
      f.input :firstname
      f.input :lastname
      f.input :dob
      f.input :sexe
      f.input :lang
    end

    f.inputs 'Licences' do
      f.has_many :licences, heading: false, allow_destroy: false, new_record: true do |a|
        a.input :num
        a.input :hcp
        a.input :club
        a.input :actif
      end
    end      

    f.inputs "User" do 
        f.has_many :user, heading: false, allow_destroy: false, new_record: !resource.user do |u|
          u.input :email
          u.input :role
          if u.object.new_record?
            u.input :password
            u.input :password_confirmation
          end
          u.input :actif
        end
    end   

    f.actions do
       f.action :submit
       f.cancel_link(url_for(:back))
    end   

  end

  show do 
    default_main_content
    div do
        button_to 'Add licence', new_admin_player_licence_path(player_id: resource.id), method: :get
    end 

    panel "Licences" do 
      table_for player.licences do
        column :num
        column :hcp
        column :club
        column :actif
        column "" do |licence|
          link_to "View", admin_player_licence_path(licence.player, licence)
        end
      end
    end
  end
  
end
