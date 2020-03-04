class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code, null: false
      t.integer :prefecture_id
      t.string :municipalitie, null: false
      t.string :street, null: false
      t.string :building
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
