require "test_helper"
require "sessions_controller"
require "sessions_helper"
class UsersControllerTest < ActionDispatch::IntegrationTest
  #include SessionsController
  setup do
    @user = users(:one)
    post login_path, params: { session: { username: "admin", password: "123456" } }
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
      post users_path, params: { user: { description: @user.description, lastname: @user.lastname, stream_link: @user.stream_link, timezone_code: @user.timezone_code, username: @user.username,password:"123456"} }
    end
    assert_redirected_to '/profile?id='+User.last.id.to_s
  end

  test "should show user" do
    get '/profile?id='+@user.id.to_s
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { description: @user.description, lastname: @user.lastname, stream_link: @user.stream_link, timezone_code: @user.timezone_code, username: @user.username,password: "123456" } }
    assert_redirected_to "/profile?id="+@user.id.to_s
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
    assert_redirected_to users_url
  end

  test "profile won't break if user enters no twitch youtube data" do
    assert_difference('User.count') do
      post users_path, params: { user: { description: @user.description, lastname: @user.lastname, stream_link:"",youtube_id:"", timezone_code: @user.timezone_code, username: @user.username,password:"123456"} }
    end
    assertError
  end

  # isn't working
  test "profile won't break if user enters bad twitch youtube data" do
    assert_difference('User.count') do
      post users_path, params: { user: { description: @user.description, lastname: @user.lastname, stream_link:"aaaaaaaaaaaa",youtube_id:"aaaaaaaaaaaa", timezone_code: @user.timezone_code, username: @user.username,password:"123456"} }
    end
    assertError
  end

  def assertError
    id=User.last.id.to_s
    error=FALSE
    begin
      get '/profile/?id='+id
      get '/profile/stream?id='+id
    rescue => exception
     error=TRUE
    end
    assert(!error)
  end
end
