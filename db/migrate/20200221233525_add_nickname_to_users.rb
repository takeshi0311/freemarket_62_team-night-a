class AddNicknameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nickname, :string, null: false
    add_column :users, :family_name, :string, null: false
    add_column :users, :last_name, :string, null: false
    add_column :users, :frigana_family_name, :string, null: false
    add_column :users, :frigana_last_name, :string, null: false
    add_column :users, :birthday_year, :integer, null: false
    add_column :users, :birthday_month, :integer, null: false
    add_column :users, :birthday_day, :integer, null: false
    add_column :users, :phone_number, :string,  null: false     
  end
end
