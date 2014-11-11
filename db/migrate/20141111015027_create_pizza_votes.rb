class CreatePizzaVotes < ActiveRecord::Migration
  def change
    create_table :pizza_votes do |t|
      t.integer :user_id
      t.string :flavor

      t.timestamps null: false
    end
  end
end
