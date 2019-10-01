class CreateFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :filters do |t|
      t.string   :title
      t.integer  :position
      t.integer  :product_setting_id, index: true
    end
  end
end
