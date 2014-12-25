ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

OmniAuth.config.test_mode = true
omniauth_hash = { 'provider' => 'github',
                  'uid' => '12346',
                  'info' => {
                      'name'     => 'Example User',
                      'email'    => 'example_user@gmail.com',
                      'nickname' => 'example_user',
                      'image'    => 'https://avatars.githubusercontent.com/u/4622588?v=2'
                  }}

OmniAuth.config.add_mock(:github, omniauth_hash)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
