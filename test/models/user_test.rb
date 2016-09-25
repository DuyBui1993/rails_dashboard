require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "Should be valid" do
    assert @user.valid?
  end

  test "Name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "Email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "Name shouldn't be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "Email shouldn't be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

   test "Email validation should accept valid address" do
     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com]
     invalid_addresses.each do |invalid_address|
       @user.email = invalid_address
       assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
     end
   end

   test "Email address should be unique" do
     dupplicate_user = @user.dup
     dupplicate_user.email = @user.email.upcase
     @user.save
     assert_not dupplicate_user.valid?
   end

   test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
