class TestProxiesController < ApplicationController
  def index
    if params[:filter].present?
      render_filtered_products
    elsif params[:search].present?
      render_searched_products
    else
      render_all_products
    end
  end

  private

  def render_all_products
    @products = ProductFilter.new(product_params).filter
    @vendor_array = Product.pluck(:vendor).uniq
    @size_array = ['L', 'M', 'S', "Women's", 'XL', 'XS', 'XXL', 'XXS']
    @product_type = Product.pluck(:product_type).uniq.reject(&:blank?)
    @price_ranges = ['0 - 31', '31 - 70', '71 - 90', '91 - 110']
    # render content_type: 'application/liquid'
  end

  def render_filtered_products
    page = params[:page]
    @products = ProductFilter.new(product_params).filter
    @products = [] if products_are_already_in_view?
    render json: {productsPartial: render_to_string('home/_products', locals: {showFirst: false}), layout: false, productCount: @products.count, lastProductID: @products.last.try(:id)}
  end

  def render_searched_products
    @products = ProductFilter.new({title: query_string}).search
    @popular = ProductFilter.new({title: query_string}).popular
    render json: {searchPartial: render_to_string('test_proxies/_search_results', layout: false) }
  end

  def product_params
    {limit: 36, title: params[:brand], product_type: params[:product_type], tag: params[:size], page: params[:page], price: params[:price], sort_by: params[:sort_by]}
  end

  def query_string
    synon = ProductSetting.last.product_synonyms.where('synonym = ?', params[:q]).first
    return params[:q] unless synon
    return synon.value
  end

  def products_are_already_in_view?
    params[:last_prod_id].present? && params[:last_prod_id] == @products.last.id.to_s rescue false
  end
end
