class AddFilterTypeToFilter < ActiveRecord::Migration[5.2]
  def change
    add_column  :filters, :filter_type, :integer, default: 0
  end
end
