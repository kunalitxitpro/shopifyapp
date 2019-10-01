class CollectionRule < ApplicationRecord
  belongs_to :collection

  SEARCH_ATTRIBUTE = {
    'variant_inventory' => 'quantity',
    'type' => 'product_type',
    'variant_price' => 'price',
    'variant_compare_at_price'  => 'compare_at_price',
    'tag' => 'tags'
  }

  def search_attribute
    SEARCH_ATTRIBUTE[super].present? ? SEARCH_ATTRIBUTE[super] : super
  end

end
