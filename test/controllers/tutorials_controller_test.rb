require 'test_helper'

class TutorialsControllerTest < ActionController::TestCase
  setup do
    @tutorial = tutorials(:vagrant_intro)
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'should show the tutorial' do
    get :show, id: @tutorial
    assert_response :success
  end
end
