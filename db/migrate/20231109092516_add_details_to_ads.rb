class AddDetailsToAds < ActiveRecord::Migration[7.0]
  def change
    add_column :ads, :details, :string
  end
end
