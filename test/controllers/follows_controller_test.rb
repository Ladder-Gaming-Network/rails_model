require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @follow = follows(:one)
    post login_path, params: { session: { username: "admin", password: "123456" } }
  end

  test "should get index" do
    get follows_url
    assert_response :success
  end

  test "should get new" do
    get new_follow_url
    assert_response :success
  end

  test "should create follow" do
    assert_difference('Follow.count') do
      # needs to be different from fixtures because of validations
      post follows_url, params: { follow: { follower_id: 1, user_id: 3} }
    end

    assert_redirected_to follow_url(Follow.last)
  end

  test "should show follow" do
    get follow_url(@follow)
    assert_response :success
  end

  test "should get edit" do
    get edit_follow_url(@follow)
    assert_response :success
  end

  test "should update follow" do
    patch follow_url(@follow), params: { follow: { follower_id: @follow.follower_id, user_id: @follow.user_id } }
    assert_redirected_to follow_url(@follow)
  end

  test "should destroy follow" do
    assert_difference('Follow.count', -1) do
      delete follow_url(@follow)
    end

    assert_redirected_to follows_url
  end
end
