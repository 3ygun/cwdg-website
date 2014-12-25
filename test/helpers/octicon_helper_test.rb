require 'test_helper'

class OcticonHelperTest < ActionView::TestCase
  test '#mega_octicon should return a span tag with the proper octicon-class' do
    assert_equal mega_octicon('github-mark'), '<span class="mega-octicon octicon-github-mark"></span>'
  end

  test '#octicon should return a span tag with the proper octicon-class' do
    assert_equal octicon('github-mark'), '<span class="octicon octicon-github-mark"></span>'
  end
end
