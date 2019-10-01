class AddIsCustomCollectionToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :is_custom_collection, :boolean, default: false
  end
end
