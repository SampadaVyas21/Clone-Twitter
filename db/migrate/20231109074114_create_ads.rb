class CreateAds < ActiveRecord::Migration[7.0]
  def change
    create_table :ads do |t|

      t.timestamps
    end
  end
end
