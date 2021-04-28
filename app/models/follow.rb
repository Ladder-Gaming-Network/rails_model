class Follow < ApplicationRecord
    belongs_to :follower, class_name: "User"
    belongs_to :user, class_name: "User"
    validates :follower_id, presence: true
    validates :user_id, presence: true
    validates_uniqueness_of :follower_id, scope: [:user_id]
end
