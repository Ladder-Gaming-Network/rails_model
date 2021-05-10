require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    post login_path, params: { session: { username: "admin", password: "123456" } }
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    # this won't work becaue there isn't a user logged in
    assert_difference('Post.count') do
      post posts_url, params: { post: { text: @post.text } }
    end

    assert_redirected_to "/profile?id="+@post.user_id.to_s
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { user_id: @post.user_id, parent_post: @post.parent_post, text: @post.text } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
