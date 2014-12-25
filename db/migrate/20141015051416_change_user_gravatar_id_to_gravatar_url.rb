class ChangeUserGravatarIdToGravatarUrl < ActiveRecord::Migration
  def change
    rename_column :users, :gravatar_id, :gravatar_url
  end
end
