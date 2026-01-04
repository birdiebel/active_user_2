ActiveAdmin.register Club do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :name,
                courses_attributes: [:id, :name, :version]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  includes :courses
  
  form do |f|
    f.input :name
    f.inputs 'Courses' do
      f.has_many :courses, heading: false, allow_destroy: false, new_record: true do |c|
        c.input :name
        c.input :version
      end
    end  
    actions       
  end

  index do 
    column :name
    actions
  end

  show do 
    default_main_content
    panel "Courses" do 
      table_for club.courses do
        column :name
        column :version
        column "Courses" do |course|
          link_to "View", admin_course_path(course)
        end
        column "Courses" do |course|
          link_to "Edit", edit_admin_course_path(course)
        end  
  
      end
    end
  end
end
