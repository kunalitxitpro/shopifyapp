class ProductSearch

  def initialize(params, shop = nil)
    @params = params
    @products = []
    @shop = shop
  end

  def search
    return get_all_products_for_tag if variant_param_present?
    shopify_api_query(shopify_params)
  end

  private

  attr_reader :params

  def shopify_params(for_variant = false)
    hash = {}
    hash.merge!(limit: params[:limit]) if params[:limit].present? && !for_variant
    hash.merge!(title: params[:title]) if params[:title].present?
    hash.merge!(product_type: params[:product_type]) if params[:product_type].present?
    hash.merge!(page: params[:page]) if params[:page].present? && !for_variant
    return hash
  end


  def variant_param_present?
    params[:tag].present? || params[:price].present? || params[:sort_by].present?
  end


  def get_all_products_for_tag
    return sorted_results if params[:sort_by].present?
    total_products = product_count_query
    total_prods_to_loop = (total_products.to_f/250).round

    total_prods_to_loop.times do |page|
      break if @products.count >= 36
      page = page + 1
      products = shopify_api_query(shopify_params(true).merge!({page: page, limit: 250})).select{|p| can_include_product?(p) }
      @products << products
      @products = @products.flatten.uniq
    end

    final_products = @products.flatten.uniq[page_for_variant, 36]
    return final_products.present? ? final_products : []
  end

  def page_for_variant
    return 0 unless params[:page].present?
    index = params[:page].to_i - 1
    index * 36
  end


  def sorted_results
    total_products = product_count_query
    total_prods_to_loop = (total_products.to_f/250).round

    total_prods_to_loop.times do |page|
      page = page + 1
      products = shopify_api_query(shopify_params(true).merge!({page: page, limit: 250})).select{|p| can_include_product?(p) }
      @products << products
      @products = @products.flatten.uniq
    end

    final_products = sort_for_products(@products)[page_for_variant, 36]
    return final_products.present? ? final_products : []
  end

  def sort_for_products(products)
    if params[:sort_by] == 'title_descending'
      return products.sort { |a,b| a.title <=> b.title }.reverse
    elsif params[:sort_by] == 'title_ascending'
      return products.sort { |a,b| a.title <=> b.title }
    elsif params[:sort_by] == 'price_ascending'
      return products.sort { |a,b| a.variants.first.price.to_f <=> b.variants.first.price.to_f }
    elsif params[:sort_by] == 'price_descending'
      return products.sort { |a,b| a.variants.first.price.to_f <=> b.variants.first.price.to_f }.reverse
    elsif params[:sort_by] == 'created_ascending'
      return products.sort { |a,b| a.created_at <=> b.created_at }
    elsif params[:sort_by] == 'created_descending'
      return products.sort { |a,b| a.created_at <=> b.created_at }.reverse
    end
  end


  def can_include_product?(product)
    if params[:tag].present? && params[:price].present?
      price_between_range_for_product?(product) && tag_is_included?(product)
    elsif params[:tag].present?
      tag_is_included?(product)
    elsif params[:price].present?
      price_between_range_for_product?(product)
    else
      true
    end
  end

  def price_between_range_for_product?(product)
    price = product.variants.first.price.to_i
    price_range[0].to_i <= price && price_range[1].to_i >= price
  end

  def tag_is_included?(product)
    product.variants.map{|a| a.title}.include?(params[:tag])
  end

  def price_range
    params[:price].gsub(" - ", ",").split(',')
  end

 # TODO refactor to block
  def shopify_api_query(params)
    if @shop.present?
      @shop.with_shopify_session do
        return ShopifyAPI::Product.find(:all, params: params)
      end
    else
      return ShopifyAPI::Product.find(:all, params: params)
    end
  end

  def product_count_query
    if @shop.present?
      @shop.with_shopify_session do
        return ShopifyAPI::Product.count()
      end
    else
      return ShopifyAPI::Product.count()
    end
  end
end
