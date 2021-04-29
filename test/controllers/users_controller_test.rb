require "test_helper"
require "sessions_controller"
require "sessions_helper"
class UsersControllerTest < ActionDispatch::IntegrationTest
  #include SessionsController
  setup do
    @user = users(:one)
    post login_path, params: { session: { username: "admin",
      password: "12346" } }
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_path, params: { user: { description: @user.description, lastname: @user.lastname, stream_link: @user.stream_link, timezone_code: @user.timezone_code, username: @user.username } }
    end

    assert_redirected_to user_url(User.last)
  end

  # fails with "Expected response to be a <2XX: success>, but was a <302: Found> redirect to <http://www.example.com/login"
  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { description: @user.description, lastname: @user.lastname, stream_link: @user.stream_link, timezone_code: @user.timezone_code, username: @user.username } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end
end
