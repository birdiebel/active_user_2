ActiveAdmin.register Tee do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :course_id, :nb_hole, :par_str, :dist_str, :stroke_str, :slope, :rating, :teebox
  #
  # or
  #
  # permit_params do
  #   permitted = [:course_id, :nb_hole, :par_str, :dist_str, :stroke_str, :slope, :rating]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  includes :course
  config.comments = false
  
end
