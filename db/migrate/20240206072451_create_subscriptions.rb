class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.integer :plan
      t.datetime :validity
      t.string :price
      t.boolean :activated, default: false
      t.timestamps
    end
  end
end
