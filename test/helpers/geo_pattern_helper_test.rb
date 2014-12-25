# I'm not going to test that the gem works
# I just want to validate that the methods
# exist
require 'test_helper'

class GeoPatternHelperTest < ActionView::TestCase
  test '#geo_pattern should return something' do
    assert_not_equal geo_pattern('Hello World'), nil
  end
  test '#geo_pattern_image should return something' do
    assert_not_equal geo_pattern_image('Hello World'), nil
  end
end
