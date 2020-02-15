class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.reference :user, foreign_key: true
      t.reference :item, foreign_key: true

      t.timestamps
    end
  end
end
