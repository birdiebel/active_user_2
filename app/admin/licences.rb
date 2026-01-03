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
  
end
