class Interest < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    validates :user_id, presence: true
    validates :interest, presence: true
end
