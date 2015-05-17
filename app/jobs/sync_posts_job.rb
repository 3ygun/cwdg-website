class SyncPostsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    github_tutorials = Octokit.contents('CWDG/blog').keep_if do |file|
      !file[:name].eql?('README.md') && file[:name] =~ /\.md/
    end

    # Remove tutorials no longer in the repo
    to_remove = (Tutorial.all.pluck(:file_name) - github_tutorials.map { |t| t[:name] })
    to_remove.each do |file_name|
      Tutorial.find_by(file_name: file_name).destroy
    end

    # Create or Update Tutorial(s)
    github_tutorials.each do |file|
      file_name = file[:name]
      sha       = file[:sha]
      title     = file_name[0..-4].titleize
      tutorial  = Tutorial.find_by(file_name: file[:name])
      download_url  = file[:download_url]

      if tutorial.nil?
        tutorial = Tutorial.create!(file_name: file_name,
                                    content:   get_tutorial_content(download_url),
                                    sha:       sha,
                                    title:     title)

        tweet_post(tutorial)
      elsif tutorial.sha != file[:sha]
        tutorial.update_attribute(:content, get_tutorial_content(download_url))
      end
    end
  end

  def get_tutorial_content(download_url)
    content = Nokogiri::HTML(open(download_url))
    content.css('body > p').children.text
  end

  def tweet_post(post)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key =         Rails.application.secrets.twitter_consumer_key
      config.consumer_secret =      Rails.application.secrets.twitter_consumer_secret
      config.access_token =         Rails.application.secrets.twitter_access_token
      config.access_token_secret =  Rails.application.secrets.twitter_access_token_secret
    end

    # Trim title if it's too long to fit in a tweet
    if post.title.size > 100
      title = title[0, 97] + '...'
    else
      title = post.title
    end

    link = "#{ENV['HOSTNAME']}/blog/#{post.id}"
    client.update("New blog post! #{title} #{link}")
  end
end
