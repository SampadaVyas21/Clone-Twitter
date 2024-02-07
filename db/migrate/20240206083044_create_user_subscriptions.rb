class CreateUserSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscriptions do |t|
      t.integer :plan
      t.datetime :validity
      t.string :price
      t.boolean :activated, default: false
      t.integer :user_id
      t.timestamps
    end
  end
end
