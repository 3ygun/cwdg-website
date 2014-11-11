class Poll < ActiveRecord::Base
  has_many :pizza_votes
end
