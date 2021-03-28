module FollowsHelper
    def self.get_user_follows(user_id)
        Follow.where(user_id:user_id).map{|follow| follow.follower_id}
    end
end
