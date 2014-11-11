class AddPollIdToPizzaVotes < ActiveRecord::Migration
  def change
    add_column :pizza_votes, :poll_id, :integer
  end
end
