require 'test_helper'

class UserTest < ActiveSupport::TestCase
 def setup
   @user = User.new(name: "Philip Weiss", email: "weissp68@stanford.edu", password: "foobar", password_confirmation: "foobar")
 end

  test "User is valid" do
    @user.valid?
  end

  test "Name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "Email should be valid" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "Email should not be too long" do
    @user.email = 'a'*255 + "example.com"
    assert_not @user.valid?
  end

  test "Name should not be too long do" do
    @user.name = 'a'*51
    assert_not @user.valid?
  end

  test "Password Not Too Short" do
    @user.password = @user.password_confirmation = "fdg"
    assert_not @user.valid?
  end

  test "Password Long Passes" do
    @user.password = @user.password_confirmation = "hellothere"
    assert @user.valid?
  end

 test "associated guides should be destroyed" do
   @user.save
   @user.guides.create!(title: "title", description: "test d")
   @user.destroy
   assert (@user.guides.count < 1)

 end
end
