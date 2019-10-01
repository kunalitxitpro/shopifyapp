class AddFieldsToProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :shopify_id
    add_column    :products, :shopify_id, :string
    add_column    :products, :product_type, :string
    add_column    :products, :sizes, :string
  end
end
