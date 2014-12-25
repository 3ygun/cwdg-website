class AddShaToTutorial < ActiveRecord::Migration
  def change
    add_column :tutorials, :sha, :string
  end
end
