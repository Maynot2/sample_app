require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Pol Sud", email: "polsud@yahoo.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be empty" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should not be empty" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "nmail should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_emails = %w[ pol@gmail.com tom@yahoo.com bob@live.fr ]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addreses" do
    invalid_emails = %w[ pol_at_gmail.com tom@yahoodotcom bob@live+hotmail.fr
    foo@bar..com ]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    user_with_same_email = @user.dup # creating a copy of the original user with the same email
    user_with_same_email.email = @user.email.upcase
    @user.save # saving the original user to the DB
    assert_not user_with_same_email.valid? # asserting that the validation is in place
  end

  test "email address is downcased before being saved" do
    email_mixcase = "Foo@ExAMPle.CoM"
    @user.email = email_mixcase
    @user.save
    assert_equal email_mixcase.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = " " * 6
    assert_not @user.valid?
  end

  test "password should be at list 6 characters long" do
    @user.password = @user.password_confirmation = "f" * 5
    assert_not @user.valid?
  end

end
