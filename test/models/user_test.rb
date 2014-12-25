require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:mark_tareshawty)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'gravatar_url should be present' do
    @user.gravatar_url = ''
    assert_not @user.valid?
  end

  test 'appends size onto gravatar_url' do
    assert_equal @user.gravatar_url_of_size(80), 'https://avatars.githubusercontent.com/u/564113?v=2&s=80'
  end

  test 'username should be present' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'if the user doesn\'t have a name, it should be set as the username' do
    @user.name = ''
    @user.save
    assert_equal @user.name, @user.username
  end

  test 'provider should be present' do
    @user.provider = ''
    assert_not @user.valid?
  end

  test 'uid should be present' do
    @user.uid = ''
    assert_not @user.valid?
  end
end
