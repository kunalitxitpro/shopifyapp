class CreateProductSynonyms < ActiveRecord::Migration[5.2]
  def change
    create_table :product_synonyms do |t|
      t.integer  :product_id, index: true
      t.string   :synonym
      t.string   :value
      t.timestamps
    end
  end
end
