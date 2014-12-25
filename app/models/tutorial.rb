class Tutorial < ActiveRecord::Base
  validates :file_name, :content, :sha, :title, presence: true
end
