class AddContentToRetweets < ActiveRecord::Migration[7.0]
  def change
    add_column :retweets, :content, :string
  end
end
