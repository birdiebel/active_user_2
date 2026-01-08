ActiveAdmin.register Club do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :name,
                courses_attributes: [:id, :name, :version, :nb_hole]
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  includes :courses

  action_item 'Close', only: [:show] do
    link_to 'Close', admin_clubs_path
  end

  # action_item 'Close', only: [:edit] do
  #   link_to 'Close', admin_club_path(resource.id)
  # end

  # controller do
  #   def create
  #     create! do |format|
  #       format.html { redirect_to collection_path, notice: "#{resource.model_name.human} was successfully created." }
  #     end
  #   end
  #   def update
  #     update! do |format|
  #       format.html { redirect_to collection_path, notice: "#{resource.model_name.human} was successfully created." }
  #     end
  #   end
  # end
  
  form do |f|
    f.inputs 'Club' do
      f.input :name
    end
    f.inputs 'Courses' do
      f.has_many :courses, heading: false, allow_destroy: false, new_record: true do |c|
        c.input :name
        c.input :version
        c.input :nb_hole
      end
    end  
    f.actions do
       f.action :submit
       f.cancel_link(url_for(:back))
    end        
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
        column :nb_hole
        column "" do |course|
          link_to "View", admin_course_path(course)
        end
      end
    end
  end
end
