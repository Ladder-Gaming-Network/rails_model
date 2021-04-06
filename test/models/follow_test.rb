require "test_helper"

class FollowTest < ActiveSupport::TestCase

  #doesn't pass?
  test "should save follow with default fields" do
    new_follow = Follow.new(user_id: 1, follower_id: 2)
    assert new_follow.save, "Did not save valid follow"
  end
end
