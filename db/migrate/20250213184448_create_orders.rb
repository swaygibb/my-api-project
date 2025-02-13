class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :shopify_id
      t.string :email
      t.decimal :total_price
      t.string :currency
      t.integer :order_number

      t.timestamps
    end
  end
end
