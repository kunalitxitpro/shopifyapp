class AddAdditionalFilterSwitches < ActiveRecord::Migration[5.2]
  def change
    add_column  :product_settings, :filter_vendor_by_variant, :boolean, default: true
    add_column  :product_settings, :filter_product_type_by_variant, :boolean, default: true
  end
end
