class AddFollowToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :follower_id, :integer
    add_column :users, :followee_id, :integer
  end
end
