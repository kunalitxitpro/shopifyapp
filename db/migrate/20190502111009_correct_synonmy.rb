class CorrectSynonmy < ActiveRecord::Migration[5.2]
  def change
    remove_column :product_synonyms, :product_id
    add_column    :product_synonyms, :product_setting_id, :integer, index: true
  end
end
