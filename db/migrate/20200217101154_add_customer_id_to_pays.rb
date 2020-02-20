class AddCustomerIdToPays < ActiveRecord::Migration[5.0]
  def change
    add_column :pays, :customer_id, :string
  end
end
