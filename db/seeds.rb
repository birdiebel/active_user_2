
# Genere
def go_players(nbCount, sexe)
    # Boucle
    (1..nbCount).each do |i|
        # User
        user = User.new
        user.email = Faker::Internet.email
        user.password = "123456"
        user.actif = true
        user.save
        puts "User #{user.id}"

        # Player
        player = Player.new
        player.user = user
        player.firstname = Faker::Name.male_first_name
        player.lastname = Faker::Name.last_name
        player.sexe = sexe
        player.dob = Faker::Date.between(from: '1955-09-23', to: '2010-09-25')
        player.save
        puts "PLayer #{i}"

        # Licence
        licence = Licence.new
        licence.player = player
        licence.num = Faker::Number.between(from: 100000, to: 999999).to_s
        licence.hcp = Faker::Number.between(from: -2.1, to: 36.4)
        licence.club = Faker::Sports::Basketball.team
        licence.save
        puts "Licence #{i}"
    end
end

def go_agecat(name, short, age_low, age_high, color, year)
    agecat = Agecat.new
    agecat.name = name
    agecat.short = short
    agecat.age_low = age_low
    agecat.age_high = age_high
    agecat.color = color
    agecat.year = year
    agecat.save
    puts "Agecat #{name}"
end

def go_playercat(name, agecat, sexe, hcp_min, hcp_max, version, teebox, priority)
    playercat = Playercat.new
    playercat.name = name
    playercat.agecat = agecat
    playercat.sexe = sexe
    playercat.hcp_min = hcp_min
    playercat.hcp_max = hcp_max
    playercat.version = version
    playercat.teebox = teebox
    playercat.priority = priority
    playercat.save
    puts "Playercat #{name}"
end

def seed_tours(name)
    # Reset datas
    Tour.delete_all
    Event.delete_all

    # Boucles
    tour1 = Tour.new
    tour1.name = "Federal Tour"
    tour1.status = :open
    tour1.actif = true
    tour1.year = 2026
    tour1.save
    puts "Tour #{tour1.name}"

    event1 = Event.new
    event1.name = "Rigenée "
    event1.status = :created
    event1.actif = true
    event1.tour = tour1
    event1.save
    puts " Event #{event1.name}"
end

# Users, players and licence
def seed_players(men, ladies)
    # Reset datas
    User.delete_all
    Player.delete_all

    # Boucles
    go_players(men, 0)
    go_players(ladies, 1)
end

def seed_agecats
    # Reset datas
    Agecat.delete_all

    # Boucles
    go_agecat("All", "A", 0, 99, "black", 2026)
    go_agecat("Junior", "J", 0, 17, "orange", 2026)
    go_agecat("Young Adult", "Y", 18, 24, "brown", 2026)
    go_agecat("Midam", "M", 25, 49, "blue", 2026)
    go_agecat("Senior", "S", 50, 99, "green", 2026)
end

def seed_playercats
    # Reset datas
    Playercat.delete_all

    # Boucles
    go_playercat("Federal", Agecat.find_by(name: "Midam"), 0, -5, 14.4, "2026", "White", 1)
    go_playercat("Federal", Agecat.find_by(name: "Midam"), 1, -5, 14.4, "2026", "Blue", 2)
    go_playercat("Future", Agecat.find_by(name: "All"), 0, 14.5, 36.4, "2026", "Yellow", 3)
    go_playercat("Future", Agecat.find_by(name: "All"), 1, 14.5, 36.4, "2026", "Red", 4)
    go_playercat("Team (bt) Serie 1", Agecat.find_by(name: "All"), 0, -5, 18.4, "2026", "White", 5)
    go_playercat("Team (bt) Serie 1", Agecat.find_by(name: "All"), 1, -5, 18.4, "2026", "Blue", 6)
    go_playercat("Team (bt) Serie 2", Agecat.find_by(name: "All"), 0, 18.5, 36.4, "2026", "Yellow", 7)
    go_playercat("Team (bt) Serie 2", Agecat.find_by(name: "All"), 1, 18.5, 36.4, "2026", "Red", 8)
end

# # Seed Players
# seed_players(50, 30)

# # Seed Agecats
# seed_agecats

# Seed Playercats
# seed_playercats

# Seed Tours and Events
seed_tours("Federal Tour")
