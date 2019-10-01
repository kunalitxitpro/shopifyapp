class AddLoadingItemsToScroll < ActiveRecord::Migration[5.2]
  def change
    add_column  :products, :shopify_created_at, :datetime
    add_column  :product_settings, :number_of_items_to_load, :integer
  end
end
