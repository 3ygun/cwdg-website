require 'test_helper'

class SyncPostsJobTest < ActiveJob::TestCase
  def setup
    # GitHub mocks
    body = [{
      :name => "git-tutorial.md",
      :path => "git-tutorial.md",
      :sha => "744a01b55be2a912a821ab6c070460723e533aa2",
      :size => 7341,
      :url => "https://api.github.com/repos/CWDG/blog/contents/git-tutorial.md?ref=master",
      :html_url => "https://github.com/CWDG/blog/blob/master/git-tutorial.md",
      :git_url => "https://api.github.com/repos/CWDG/blog/git/blobs/744a01b55be2a912a821ab6c070460723e533aa2",
      :download_url => "https://raw.githubusercontent.com/CWDG/blog/master/git-tutorial.md",
      :type => "file",
      :_links => {
        :self => "https://api.github.com/repos/CWDG/blog/contents/git-tutorial.md?ref=master",
        :git => "https://api.github.com/repos/CWDG/blog/git/blobs/744a01b55be2a912a821ab6c070460723e533aa2",
        :html => "https://github.com/CWDG/blog/blob/master/git-tutorial.md"
      }
    }]
    stub_request(:get, "https://api.github.com/repos/CWDG/blog/contents/").
      to_return(:status => 200, :body => body, :headers => {})
    stub_request(:get, 'https://raw.githubusercontent.com/CWDG/blog/master/git-tutorial.md').
      to_return(status: 200, body: "# Git Tutorial")

    # Twitter mocks
    stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
      to_return(status: 200, body: "{\"id\": 1234567890}")
  end

  test "syncing adds post" do
    SyncPostsJob.perform_now

    assert_equal 1, Tutorial.count
    assert_equal "Git Tutorial", Tutorial.first.title
  end

  test "syncing updates posts" do
    Tutorial.create!({file_name: "git-tutorial.md", title: "Git Tutorial",
                      sha: "1234", content: "# Old Content"})

    SyncPostsJob.perform_now

    assert_equal "# Git Tutorial", Tutorial.first.content
  end

  test "syncing deletes posts" do
    Tutorial.create!({file_name: "hello-world.rb", title: "Hello World",
                      sha: "5678", content: "# Hello World!"})

    SyncPostsJob.perform_now

    assert_equal 1, Tutorial.count
    assert_equal "Git Tutorial", Tutorial.first.title
  end
end
