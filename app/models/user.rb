class User < ActiveRecord::Base
  before_save { self.name = self.username if self.name.blank? }

  validates :gravatar_url, :provider, :uid, :username, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.gravatar_url  = auth['info']['image']
      user.name          = auth['info']['name']
      user.provider      = auth['provider']
      user.uid           = auth['uid']
      user.username      = auth['info']['nickname']
    end
  end

  def gravatar_url_of_size(size)
    "#{self.gravatar_url}&s=#{size}"
  end
end
