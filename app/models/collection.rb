class Collection < ApplicationRecord
  has_many :collection_rules

  SQL_RULE_IDENTIFIER = {
    'equals' => '=',
    'greater_than' => '>',
    'not_equals' => '!=',
    'less_than' => '<'
  }

  SQL_SORT_IDENTIFIER = {
    'best-selling' => 'price DESC',
    'price-desc' => 'price DESC',
    'created-desc' => 'shopify_created_at DESC',
    'created' => 'shopify_created_at ASC'
  }

  def sql_based_rules
    return self.rules_for_custom_collection if self.is_custom_collection
    sql_array = []
    self.collection_rules.each do |rule|
      if rule.search_attribute == 'tags'
        sql_array << "tags LIKE '%#{rule.condition}%'"
      elsif rule.rule_identifier == 'contains'
        sql_array << "#{rule.search_attribute} LIKE '%#{rule.condition}%'"
      elsif rule.rule_identifier == 'not_contains'
        sql_array << "#{rule.search_attribute} NOT LIKE '%#{rule.condition}%'"
      elsif rule.rule_identifier == 'ends_with'
        sql_array << "#{rule.search_attribute} LIKE '% #{rule.condition}% '"
      else
        sql_array << "#{rule.search_attribute} #{SQL_RULE_IDENTIFIER[rule.rule_identifier]} '#{rule.condition}'"
      end
    end
    sql_array.join(" #{self.disjunctive ? 'OR' : 'AND'} ")
  end

  def sql_for_order
    SQL_SORT_IDENTIFIER[self.sort_order].present? ? SQL_SORT_IDENTIFIER[self.sort_order] : 'shopify_created_at DESC'
  end

  def rules_for_custom_collection
    product_ids = Collect.where(shopify_collection_id: self.shopify_collection_id).pluck(:shopify_product_id).uniq.map{|a| "'#{a}'"}
    return "products.shopify_id IN (#{product_ids.join(', ')})"
  end
end
