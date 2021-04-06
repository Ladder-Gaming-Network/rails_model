require "test_helper"

class PostTest < ActiveSupport::TestCase

  #doesn't pass?
  test "should save post with default fields" do
    new_post = Post.new(user_id: 1, text: "Testing...", parent_post: 3)
    assert new_post.save, "Did not save valid post"
  end

end
