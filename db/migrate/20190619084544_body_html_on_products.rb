class BodyHtmlOnProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :body_html, :text
  end
end
