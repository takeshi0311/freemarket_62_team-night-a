class AddUserIdToPays < ActiveRecord::Migration[5.0]
  def change
    add_column :pays, :user_id, :integer
  end
end
