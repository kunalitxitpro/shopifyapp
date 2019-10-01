class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :title
      t.string  :vendor
      t.string  :tags
      t.integer :shopify_id
      t.string  :first_image_url
      t.string  :second_image_url
      t.float   :price
      t.float   :compare_at_price
      t.timestamps
    end
  end
end
