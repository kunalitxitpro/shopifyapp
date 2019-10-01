class CreateCollects < ActiveRecord::Migration[5.2]
  def change
    create_table :collects do |t|
      t.string :shopify_collection_id
      t.string :shopify_product_id
      t.integer :position
      t.timestamps
    end
  end
end
