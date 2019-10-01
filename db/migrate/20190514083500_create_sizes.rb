class CreateSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :sizes do |t|
      t.integer    :product_id, index: true
      t.string     :title
      t.integer    :inventory_quantity
      t.string     :shopify_id
      t.timestamps
    end
  end
end
