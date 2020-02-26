class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      # t.string :sizerail
      # t.integer :status, null: false
      # t.string :shipping_charges, null: false
      # t.string :shipping_method, null: false
      # t.string :region, null: false
      # t.integer :price, null: false
      # t.string :shopping_date, null: false
      
      t.timestamps
    end
  end
end
