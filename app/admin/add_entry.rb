ActiveAdmin.register_page "add_entry" do
  # menu label: "Add Entry"

  # -----------------------------
  # Routes
  # -----------------------------
  page_action :create_entry, method: :post do
    player = Player.find(params[:player_id])
    puts "Creating entry for player #{player.full_name}"
    Entry.create!(
      player: player,
      event_id: params[:event_id] || 1,
      )

    redirect_to admin_add_entry_path,
                notice: "Entry créée avec succès"
  end

  # -----------------------------
  # Controller
  # -----------------------------
  controller do
    def index
      @players = Player.none

      if params.dig(:search, :lastname).present?
        @players = Player
          .where("lastname ILIKE ?", "%#{params[:search][:lastname]}%")
          .order(:lastname)
          .limit(10)
        puts "FOUND PLAYERS: #{@players.count}"
      end
    end
  end

  # -----------------------------
  # View
  # -----------------------------
  content title: "Recherche de joueurs" do
    @arbre_context.assigns[:players]

    panel "Rechercher un joueur par nom" do
      active_admin_form_for :search, url: admin_add_entry_path, method: :get do |f|
        f.inputs do
          f.input :lastname, label: "Nom du joueur"
        end
        f.actions do
          f.action :submit, label: "Rechercher"
        end
      end
    end

    panel "Résultats (max 10)" do
      if players.present?
        table_for players do |player|
          column :id
          column :firstname
          column :lastname

          column "Action" do |player|
          button_to "Créer une entry",
            { action: :create_entry, player_id: player.id },
            method: :post,
            data: { confirm: "Créer une entry pour ce joueur ?" }
          end
        end
      else
        para "Aucun joueur trouvé."
      end
    end
  end
end
