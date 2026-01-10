
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

# Seed Players
# seed_players(50, 30)

# Seed Agecats
seed_agecats
