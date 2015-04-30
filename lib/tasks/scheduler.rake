require 'open-uri'

desc 'Tasks that deal with the CWDG tutorials'
namespace :tutorials do
  desc 'Remove all tutorials in the DB'
  task destroy_all: :environment do
    puts "Destroying all tutorials..."
    Tutorial.destroy_all
    puts "Done!"
  end
end
