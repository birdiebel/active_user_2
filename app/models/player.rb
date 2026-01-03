class Player < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "dob", "firstname", "id", "lang", "lastname", "sexe", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user"]
    end

    belongs_to :user, optional: true
    has_many :licences

    validates :firstname, presence: true
    validates :lastname, presence: true

    enum :sexe, [:Men, :Ladies]
    enum :lang, [:Fr, :Nl, :En]

    accepts_nested_attributes_for :licences


    def full_name
        "#{self.firstname} #{self.lastname}"
    end

    def my_user
        if self.user
             self.user.email
        else
            "<span class='is_red'>X</span>".html_safe
        end
    end

    def my_licence
        if self.licences.empty?
            "<span class='is_red'>X</span>".html_safe
        else
            lic = self.licences.first
            count_lic = self.licences.count
            if count_lic > 1
                "<span class='is_bold'>#{lic.num} (#{lic.hcp}) (#{count_lic})</span>".html_safe
            else
                "<span class='is_bold'>#{lic.num} (#{lic.hcp})</span>".html_safe
            end
        end
    end

end
