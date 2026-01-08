ActiveAdmin.register Tee do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :course_id, :par_str, :dist_str, :stroke_str, :slope, :rating, :teebox
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

  action_item 'Close', only: [:show] do
    link_to 'Close', admin_club_course_path(resource.course.club.id, resource.course.id)
  end

  # action_item 'Close', only: [:edit] do
  #   link_to 'Close', admin_tee_path(resource.id)
  # end

  controller do
    def update
      super do |success, failure|
        success.html { redirect_to admin_club_course_path(resource.course.club_id,resource.course.id) }
      end
    end
  end

  index do
    column :course
    column :teebox
    actions
  end

  form do |f|
    # panel "Form" do
    #   f.inputs "Tee" do
    #     f.input :course
    #     f.input :nb_hole
    #     f.input :par_str
    #     f.input :dist_str
    #     f.input :stroke_str
    #     f.input :slope
    #     f.input :rating
    #     f.input :teebox
    #   end
    #   f.actions do
    #     f.action :submit
    #     f.cancel_link(url_for(:back))
    #   end  
    # end
    panel "Scorecard" do
        render 'admin/tees/score_inputs', {tee: tee}
    end            
  end

  show do
    # default_main_content   
    panel "Scorecard" do 
      render 'admin/tees/scorecard', {tee: tee, course: tee.course}
    end
  end
  
end
