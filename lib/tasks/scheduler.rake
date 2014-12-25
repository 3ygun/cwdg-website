require 'open-uri'

desc 'Tasks that deal with the CWDG tutorials'
namespace :tutorials do
  desc 'Remove all tutorials in the DB'
  task destroy_all: :environment do
    puts "Destroying all tutorials..."
    Tutorial.destroy_all
    puts "Done!"
  end

  desc 'Sync with CWDG/tutorials'
  task sync: :environment do
    github_tutorials = Octokit.contents('CWDG/tutorials').keep_if do |file|
      !file[:name].eql?('README.md') && file[:name] =~ /\.md/
    end

    # Remove tutorials no longer in the repo
    (Tutorial.all.pluck(:file_name) - github_tutorials.map { |t| t[:name] }).each do |file_name|
      puts "Removing #{file_name}..."
      Tutorial.find_by(file_name: file_name).destroy
      puts "Done!"
    end

    # Create or Update Tutorial(s)
    github_tutorials.each do |file|
      file_name = file[:name]
      sha       = file[:sha]
      title     = capitalize_all(file_name[0..-4])
      tutorial  = Tutorial.find_by(file_name: file[:name])

      if tutorial.nil?
        puts "Creating #{title}..."
        Tutorial.new(file_name: file_name,
                     content:   get_tutorial_content(file_name),
                     sha:       sha,
                     title:     title).save
        puts "Done!"
      elsif tutorial.sha != file[:sha]
        puts "Updating #{title}..."
        tutorial.update_attribute(:content, get_tutorial_content(file_name))
        puts "Done!"
      end
    end
  end

  def capitalize_all(sentence)
    sentence.split(/\W/).map(&:capitalize).join(' ')
  end

  def get_tutorial_content(file_name)
    content = Nokogiri::HTML(open("https://raw.githubusercontent.com/CWDG/tutorials/master/#{file_name}"))
    content.css('body > p').children.text
  end
end
