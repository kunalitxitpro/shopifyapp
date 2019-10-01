class AddHandleToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column  :products, :slug_url, :string
  end
end
