class AddBluetickToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bluetick, :boolean, default: false
  end
end
