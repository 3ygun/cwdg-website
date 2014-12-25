require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  test '#new should redirect to /auth/github' do
    get :new
    assert_redirected_to '/auth/github'
  end

  test '#create should create a user' do
    assert_difference 'User.count', 1 do
      post :create, provider: :github
    end
  end

  test '#create should create a session' do
    assert_equal session[:user_id], nil
    post :create, provider: :github
    assert_not session[:user_id].nil?
  end

  test '#create should redirect the user to the user\'s personal url' do
    post :create, provider: :github
    user = User.last
    assert_redirected_to user_path(user)
  end

  test '#destroy should clear the session' do
    post :create, provider: :github
    assert_not_equal session[:user_id], nil
    delete :destroy
    assert_equal session[:user_id], nil
  end

  test '#destroy should redirect to the homepage' do
    post :create, provider: :github
    delete :destroy
    assert_redirected_to root_url
  end

  test '#failure should redirect to the homepage' do
    post :create, provider: :github
    delete :destroy
    assert_redirected_to root_url
  end
end
