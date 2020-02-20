class AddCardIdToPays < ActiveRecord::Migration[5.0]
  def change
    add_column :pays, :card_id, :string
  end
end
