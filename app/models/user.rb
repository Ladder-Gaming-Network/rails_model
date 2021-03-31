
class User < ApplicationRecord
    include FollowsHelper

    validates :username, presence: true
    validates :lastname, presence: true
    validates :description, presence: true
    validates :timezone_code, presence: true

    has_secure_password
    before_save { self.username = username.downcase }
    validates :password, presence: true, length: { minimum: 6 }


    has_many :posts

    has_many :active_relationships, class_name:  "Follow",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :following, through: :active_relationships, source: :user

    def followers
        User.find( FollowsHelper.get_user_follows(self.id))
    end

    def self.search(keywords)
        # assume either keywords or subject code is valid
        formatted_keywords="%#{keywords}%"
        searched_users=User.all()
        if !keywords.blank?
            searched_users=searched_users.where("username LIKE (?) or description LIKE (?)", formatted_keywords,formatted_keywords)
        end
        #searched_users
    end
end
