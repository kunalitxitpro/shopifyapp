class ShopifyApiConnector

  def initialize()
    @connection = set_connection
  end

  def refresh_collections
    Collection.destroy_all
    CollectionRule.destroy_all
    Collect.destroy_all

    collections = get_smart_collections
    collections.each do |collection|
      if collection['published_at'].present?
        coll = Collection.new(title: collection['title'], handle: collection['handle'], sort_order: collection['sort_order'], shopify_collection_id: collection['id'], disjunctive: collection['disjunctive'])
        coll.save

        collection['rules'].each do |rule_hash|
          rule = CollectionRule.new(collection_id: coll.id, search_attribute: rule_hash['column'], rule_identifier: rule_hash['relation'], condition: rule_hash['condition'])
          rule.save
        end
      end
    end

    get_custom_collections.each do |cc|
      coll = Collection.new(title: cc['title'], handle: cc['handle'], sort_order: cc['sort_order'], shopify_collection_id: cc['id'], is_custom_collection: true)
      coll.save

      total_collects = custom_collection_count(coll.shopify_collection_id)
      total_collects_to_loop = (total_collects.to_f/250).ceil


      collects = []
      page = 0
      total_collects_to_loop.times do |page|
        page = page + 1
        collects << get_collection(coll.shopify_collection_id, page)
      end

      collects.flatten.each do |collect|
        collect = Collect.new(shopify_collection_id: collect['collection_id'], shopify_product_id: collect['product_id'], position: collect['position'])
        collect.save
      end
    end
  end

  private


  def get_collection(collection_id, page)
    response = @connection.get "https://truevintageclothing.myshopify.com/admin/api/2019-04/collects.json?collection_id=#{collection_id}&page=#{page}&limit=250"
    body = JSON.parse(response.body)
    body['collects']
  end


  def custom_collection_count(collection_id)
    response = @connection.get "https://truevintageclothing.myshopify.com/admin/api/2019-04/custom_collections/count.json?limit=250&collection_id=#{collection_id}"
    body = JSON.parse(response.body)
    body['count']
  end


  def get_custom_collections
    response = @connection.get 'https://truevintageclothing.myshopify.com/admin/api/2019-04/custom_collections.json?limit=250'
    body = JSON.parse(response.body)
    body['custom_collections']
  end

  def get_smart_collections
    response = @connection.get 'https://truevintageclothing.myshopify.com/admin/api/2019-07/smart_collections.json?limit=250'
    body = JSON.parse(response.body)
    body['smart_collections']
  end

  def set_connection
    conn = Faraday.new
    conn.basic_auth(ENV['SHOP_API_USERNAME'], ENV['SHOP_API_PASSWORD'])
    conn
  end
end
