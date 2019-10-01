class CreateCollectionRules < ActiveRecord::Migration[5.2]
  def change
    create_table :collection_rules do |t|
      t.integer :collection_id
      t.string  :search_attribute
      t.string  :rule_identifier
      t.string  :condition
      t.timestamps
    end
  end
end
