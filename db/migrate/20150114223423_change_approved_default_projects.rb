class ChangeApprovedDefaultProjects < ActiveRecord::Migration
  def change
    change_column_default :projects, :approved, false
  end
end
