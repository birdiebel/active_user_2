ActiveAdmin.register Course do

  permit_params :id, :name, :club_id, :version, :nb_hole,
                tees_attributes: [:id, :course_id, :par_str, :dist_str, :stroke_str, :slope, :rating, :teebox] 
  
  includes :club, :tees
  config.comments = false

  action_item 'Close', only: [:show] do
    link_to 'Close', admin_club_path(resource.club_id)
  end

  form do |f|
    f.inputs 'Course' do
      f.input :name
      f.input :version
    end  
    f.inputs 'Tees' do
      f.has_many :tees, heading: false, allow_destroy: false, new_record: true do |c|
        c.input :teebox
        c.input :par_str
        c.input :dist_str
        c.input :stroke_str
        c.input :slope
        c.input :rating
      end
    end  
    f.actions do
       f.action :submit
       f.cancel_link(url_for(:back))
    end   
  end

  show do 
    default_main_content
    panel "Tees" do 
      table_for course.tees do
        column  do |tee|
          raw tee.icon_teebox
        end
        column :teebox
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
