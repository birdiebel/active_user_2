ActiveAdmin.register Player do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :firstname, :lastname, :dob, :sexe, :lang, :user_id,
                licences_attributes: [:id, :num, :hcp, :club]
  #
  # or
  #
  # permit_params do
  #   permitted = [:firstname, :lastname, :dob, :sexe, :lang, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  includes :user, :licences

  filter :lastname

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

    f.actions
  end
  
end
