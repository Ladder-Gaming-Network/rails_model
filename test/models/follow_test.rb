require "test_helper"

class FollowTest < ActiveSupport::TestCase

  test "should save follow with default fields" do
    new_follow = Follow.new(user_id: User.first.id, follower_id: User.first.id)
    assert new_follow.save!, "Did not save valid follow"
  end

  test "should not save follow with no user id" do
    new_follow = Follow.new(follower_id: User.first.id)
    assert_not new_follow.save, "Saved invalid follow"
  end

  test "should save follow with follower id" do
    new_follow = Follow.new(user_id: User.first.id)
    assert_not new_follow.save, "Saved invalid follow"
  end
end
