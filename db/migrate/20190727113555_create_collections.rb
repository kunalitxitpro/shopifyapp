class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :handle
      t.string :title
      t.string :sort_order
      t.timestamps
    end
  end
end
