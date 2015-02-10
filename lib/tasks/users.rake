namespace :users do
  task :add_admin_level => :environment do
    User.update_all(admin_level: 0)
  end
end
