class UpdateNameToFileNameAndAddTitleToTutorial < ActiveRecord::Migration
  def change
    add_column :tutorials, :title, :string
    rename_column :tutorials, :name, :file_name
  end
end
