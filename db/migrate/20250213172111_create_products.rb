class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :body_html
      t.string :vendor
      t.string :product_type
      t.integer :shopify_id

      t.timestamps
    end
  end
end
