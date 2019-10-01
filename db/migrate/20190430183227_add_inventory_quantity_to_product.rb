class AddInventoryQuantityToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column  :products, :quantity, :integer
    add_column  :product_settings, :include_out_of_stock_products, :boolean, default: true
  end
end
