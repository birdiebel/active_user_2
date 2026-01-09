ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :id, :email, :actif, :role, :password,
                :password_confirmation, :encrypted_password,
                :reset_password_token, :reset_password_sent_at,
                :remember_created_at,
                player_attributes: [ :id, :firstname, :lastname, :dob, :sexe, :lang ]

  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  includes :player

  filter :email_cont
  filter :actif

  action_item "Close", only: [ :show ] do
    link_to "Close", admin_users_path
  end

  action_item "Close", only: [ :edit ] do
    link_to "Close", admin_user_path(resource.id)
  end

  form title: "User" do |f|
    f.inputs "Details" do
      input :email
      input :role
      if f.object.new_record?
        input :password
        input :password_confirmation
      end
      input :actif
    end

    f.inputs "Player", for: [ :player, f.object.player || Player.new ], new_record: false do |p|
        p.input :firstname
        p.input :lastname
        p.input :dob
        p.input :sexe
        p.input :lang
    end
    actions
  end

  index do
    column :id
    column :actif
    column :email
    column :role
    column :player
    actions
  end

  show do
    attributes_table_for(user) do
      row :actif
      row :email
      row :role
    end
    if user.player
      panel "Player" do
          attributes_table_for(user.player) do
            row :firstname
            row :lastname
            row :dob
            row :sexe
            row :lang
          end
      end
    else
      h3 style: "color: red" do
        "No player"
      end
    end
  end
end
