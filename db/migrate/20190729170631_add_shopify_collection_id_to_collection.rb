class AddShopifyCollectionIdToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :shopify_collection_id, :string
  end
end
