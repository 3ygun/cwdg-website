require 'test_helper'

class TutorialTest < ActiveSupport::TestCase
  def setup
    @tutorial = tutorials(:vagrant_intro)
  end

  test 'should be valid?' do
    assert @tutorial.valid?
  end

  test 'content should be present' do
    @tutorial.content = ''
    assert_not @tutorial.valid?
  end

  test 'file_name should be present' do
    @tutorial.file_name = ''
    assert_not @tutorial.valid?
  end

  test 'sha should be present' do
    @tutorial.sha = ''
    assert_not @tutorial.valid?
  end

  test 'title should be present' do
    @tutorial.title = ''
    assert_not @tutorial.valid?
  end
end
