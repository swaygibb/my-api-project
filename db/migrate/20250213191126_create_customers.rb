class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.bigint :shopify_id
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
