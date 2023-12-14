class AddPriorkeyToAds < ActiveRecord::Migration[7.0]
  def change
    add_column :ads, :priorkey, :integer
  end
end
