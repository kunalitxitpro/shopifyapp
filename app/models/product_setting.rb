class ProductSetting < ApplicationRecord
  mount_uploader :image, LoaderUploader
  has_many :product_synonyms
  has_many :filters
  accepts_nested_attributes_for :product_synonyms, allow_destroy: true

  def filter_array
    filter_order.split(',')
  end
end
