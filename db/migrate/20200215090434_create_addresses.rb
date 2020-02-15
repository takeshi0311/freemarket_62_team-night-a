class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :postal_code, null: false
      t.string :prefecture, null: false
      t.string :municipalitie, null: false
      t.string :building
      t.reference :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
