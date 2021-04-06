require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should save user with default fields" do
    new_user = User.new(  username: "Gravity",
                      lastname: "Falls",
                      stream_link: "twitch.com/gravityfalls",
                      description: "Testing...",
                      timezone_code: 0,
                      password:"123456",
                      password_confirmation:"123456")
    assert new_user.save, "Did not save valid user"
  end

  test "should not save user without username" do
    user = User.new(  lastname: "Falls",
                      stream_link: "twitch.com/gravityfalls",
                      description: "Testing...",
                      timezone_code: 0,
                      password:"123456",
                      password_confirmation:"123456")
    assert_not user.save, "Saved the user without a username"
  end  

  test "should not save user without lastname" do
    user = User.new(  username: "Gravity",
                      stream_link: "twitch.com/gravityfalls",
                      description: "Testing...",
                      timezone_code: 0,
                      password:"123456",
                      password_confirmation:"123456")
    assert_not user.save, "Saved the user without a lastname"
  end

  test "should not save user without description" do
    user = User.new(  username: "Gravity",
                      stream_link: "twitch.com/gravityfalls",
                      description: "Testing...",
                      timezone_code: 0,
                      password:"123456",
                      password_confirmation:"123456")
    assert_not user.save, "Saved the user without a description"
  end

  test "should not save user without timezone code" do
    user = User.new(  username: "Gravity",
                      lastname: "Falls",
                      stream_link: "twitch.com/gravityfalls",
                      description: "Testing...",
                      password:"123456",
                      password_confirmation:"123456")
    assert_not user.save, "Saved the user without a timezone code"
  end

  test "should not save user without password" do
    user = User.new(  username: "Gravity",
                      lastname: "Falls",
                      stream_link: "twitch.com/gravityfalls",
                      description: "Testing...",
                      timezone_code: 0)
    assert_not user.save, "Saved the user without a password"
  end
end
