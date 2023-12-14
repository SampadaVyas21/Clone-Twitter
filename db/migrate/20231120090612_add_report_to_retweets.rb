class AddReportToRetweets < ActiveRecord::Migration[7.0]
  def change
    add_column :retweets, :report, :boolean
  end
end
