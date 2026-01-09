# Users, players and licence

NbMe = 100
NbLadies = 50

# Reset datas
User.delete_all
Player.delete_all

# Genere
def godo(nbCount, sexe)
    # Boucle
    (1..nbCount).each do |i|
        # User
        user = User.new
        user.email = Faker::Internet.email
        user.password = "123456"
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

# Boucles
godo(NbMe,0)
godo(NbLadies,1)

