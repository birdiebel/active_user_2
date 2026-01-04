ActiveAdmin.register Course do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :name, :club_id, :version,
                tees_attributes: [:id, :course_id, :nb_hole, :par_str, :dist_str, :stroke_str, :slope, :rating, :teebox] 
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :club_id, :version]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  includes :club, :tees
  config.comments = false
  
  form do |f|
    f.inputs 'Course' do
      f.input :name
    end  
    f.inputs 'Tees' do
      f.has_many :tees, heading: false, allow_destroy: false, new_record: true do |c|
        c.input :teebox
        c.input :nb_hole
        c.input :par_str
        c.input :dist_str
        c.input :stroke_str
        c.input :slope
        c.input :rating
      end
    end  
    actions       
  end

  show do 
    default_main_content
    panel "Tees" do 
      table_for course.tees do
        column :teebox
        column :nb_hole
        column "Par", proc { |record| record.sum_str("par_str") }
        column "Long", proc { |record| record.sum_str("dist_str") }
        column :slope
        column :rating  
        column "" do |tee|
          link_to "View", admin_tee_path(tee)
        end
        column "" do |tee|
          link_to "Edit", edit_admin_tee_path(tee)
        end  
      end
    end
  end

end
