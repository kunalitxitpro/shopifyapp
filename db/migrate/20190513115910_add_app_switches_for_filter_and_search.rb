class AddAppSwitchesForFilterAndSearch < ActiveRecord::Migration[5.2]
  def change
    add_column  :product_settings, :true_filter_on, :boolean, default: true
    add_column  :product_settings, :true_search_on, :boolean, default: true
  end
end
