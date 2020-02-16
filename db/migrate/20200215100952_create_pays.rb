class CreatePays < ActiveRecord::Migration[5.0]
  def change
    create_table :pays do |t|
      t.integer :card_number, null: false
      t.integer :month, null: false
      t.integer :year, null: false
      t.integer :security_code, null: false

      t.timestamps
    end
  end
end
