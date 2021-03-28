
class User < ApplicationRecord
    include FollowsHelper

    validates :username, presence: true
    validates :lastname, presence: true
    validates :description, presence: true
    validates :timezone_code, presence: true


    has_many :posts

    has_many :active_relationships, class_name:  "Follow",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
    has_many :following, through: :active_relationships, source: :user

    def followers
        User.find( FollowsHelper.get_user_follows(self.id))
    end
end
