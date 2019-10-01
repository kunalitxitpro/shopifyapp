class AddBrandFilterOrderToProductSettings < ActiveRecord::Migration[5.2]
  def change
    add_column  :product_settings, :filter_order, :text
  end
end
