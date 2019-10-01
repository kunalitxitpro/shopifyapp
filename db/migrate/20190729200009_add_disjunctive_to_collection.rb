class AddDisjunctiveToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :disjunctive, :boolean, default: true
  end
end
