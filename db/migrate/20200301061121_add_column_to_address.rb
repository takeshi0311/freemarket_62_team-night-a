class AddColumnToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :street, :string, null: false
    add_column :addresses, :user_id, :integer, null: false
  end
end
