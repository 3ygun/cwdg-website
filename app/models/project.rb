class Project < ActiveRecord::Base
  # Double associations are weird
  belongs_to :leader, foreign_key: 'leader_id', class_name: 'User'
  has_and_belongs_to_many :users
end
