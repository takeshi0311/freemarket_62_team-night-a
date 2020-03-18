class AddNumcountToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :Favorites_count, :integer
  end
end