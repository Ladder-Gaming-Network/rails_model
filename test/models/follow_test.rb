require "test_helper"

class FollowTest < ActiveSupport::TestCase

  #belongs_to might throw error here
  test "should save follow with default fields" do
    puts(User.all.inspect)
    new_follow = Follow.new(user_id: 1, follower_id: 2)
    assert new_follow.save!, "Did not save valid follow"
  end
end
