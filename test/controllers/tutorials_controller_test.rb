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

  # Required for tweet URLs to be accurate
  test 'should route to tutorials with blog keyword' do
    assert_routing "/blog/#{@tutorial.id}", { controller: "tutorials",
                                              action: "show",
                                              id: @tutorial.id.to_s }
  end
end
