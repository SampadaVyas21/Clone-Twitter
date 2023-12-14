class AddReportToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :report, :boolean
  end
end
