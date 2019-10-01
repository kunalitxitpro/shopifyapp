class CreateProductSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :product_settings do |t|
      t.string :image
      t.timestamps
    end
  end
end
