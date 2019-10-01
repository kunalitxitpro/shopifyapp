class ProductSynonym < ApplicationRecord
  belongs_to :product_setting
  validates_presence_of :synonym, :value
end
