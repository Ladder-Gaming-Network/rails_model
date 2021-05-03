require "test_helper"

class PostTest < ActiveSupport::TestCase

  test "should save post with default fields" do
    puts(User.first.inspect)
    new_post = Post.new(user_id: User.first.id, text: "Testing...", parent_post: 3)
    assert new_post.save!, "Did not save valid post"
  end

  test "should not save post missing user id" do
    new_post = Post.new(text: "Testing...", parent_post: 3)
    assert_not new_post.save, "Saved post without user id"
  end

  test "should not save post missing text" do
    new_post = Post.new(user_id: 1, parent_post: 3)
    assert_not new_post.save, "Saved post without user id"
  end

  test "should save post missing parent_post" do
    new_post = Post.new(text: "Testing...", user_id: 1)
    assert new_post.save, "Saved post without parent post"
  end

end
