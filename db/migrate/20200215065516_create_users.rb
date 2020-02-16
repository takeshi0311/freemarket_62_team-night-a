class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :family_name, null: false
      t.string :last_name, null: false
      t.string :frigana_family_name, null: false
      t.string :frigana_last_name, null: false
      t.integer :birthday, null: false
      t.integer :phone_number, null: false
      t.text :profile

      t.timestamps
    end
  end
end
