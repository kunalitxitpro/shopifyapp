class AddOtherFieldsForSearchAndScroll < ActiveRecord::Migration[5.2]
  def change
    add_column  :product_settings, :related_search_on, :boolean, default: true
    add_column  :product_settings, :autoscroll_on, :boolean, default: true
    add_column  :product_settings, :load_more_text, :string
  end
end
