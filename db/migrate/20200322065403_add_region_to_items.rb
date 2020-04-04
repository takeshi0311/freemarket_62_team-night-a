class AddRegionToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :region, :string
  end
end
