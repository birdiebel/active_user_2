ActiveAdmin.register Player do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :firstname, :lastname, :dob, :sexe, :lang, :user_id 
  #
  # or
  #
  # permit_params do
  #   permitted = [:firstname, :lastname, :dob, :sexe, :lang, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  includes :user

  filter :lastname

  form do |f|
    f.inputs 'Player informations' do
      f.input :user_id, label: 'User', as: :select, collection: User.all.map { |u| ["#{u.id}, #{u.email}", u.id] }   
      f.input :firstname
      f.input :lastname
      f.input :dob
      f.input :sexe
      f.input :lang
    end
    f.actions
  end
  
end
