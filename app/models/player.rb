class Player < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "dob", "firstname", "id", "lang", "lastname", "sexe", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end

    belongs_to :user, optional: true

    validates :firstname, presence: true
    validates :lastname, presence: true

    enum :sexe, [:Men, :Ladies]
    enum :lang, [:Fr, :Nl, :En]

    def full_name
        "#{self.firstname} #{self.lastname}"
    end

end
