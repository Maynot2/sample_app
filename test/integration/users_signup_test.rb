require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: ' ', email: 'invalid@email',
                                          password: 'foo',
                                          password_confirmation: 'bar' }}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post signup_path, params: { user: { name: "Bob Test",
                                          email: "bobtest@gmail.com",
                                          password: "foobar",
                                          password_confirmation: "foobar" }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert flash.any?
    assert_select 'div.alert-success'
  end

end
