class AddOverflowScrollToProductSettings < ActiveRecord::Migration[5.2]
  def change
    add_column  :product_settings, :overflow_scroll_on, :boolean, default: true
  end
end
