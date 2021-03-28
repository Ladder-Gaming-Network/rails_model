class Post < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    validates :user_id, presence: true
    validates :text, presence: true
end
