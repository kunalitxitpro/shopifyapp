# frozen_string_literal: true

class HomeController < AuthenticatedController
  def index
    @products = Product.all
    # @products = ProductSearch.new(product_params).search
    # @webhooks = ShopifyAPI::Webhook.find(:all)
    @vendor_array = ['Adidas', 'American Sports Teams','Aquascutum','Armani','Asics', 'Avirex', 'Barbour', 'Belstaff', 'Best Company', 'Burberry', 'Nike']
    @size_array = ['L', 'M', 'S', "Women's", 'XL', 'XS', 'XXL', 'XXS']
    @product_type = ['Bags', 'dress', 'Football shirts', 'Hockey Top', 'Jackets & Coats', 'Jeans', 'Party Shirts', 'Polo Shirts', 'Rugby Tops', 'Shirts', 'Shorts', 'Skirts', 'Sweatshirts & Hoods', 'T-Shirts', 'Tracksuit', 'Tracksuit Bottoms', 'Trainers', 'Vests', 'Wholesale']
    @price_ranges = ['0 - 31', '31 - 70', '71 - 90', '91 - 110']
  end

  def products
    page = params[:page]
    # @products = ShopifyAPI::Product.find(:all, params: { limit: 36, page: page })
    @products = ProductSearch.new(product_params).search
    @products = [] if products_are_already_in_view?
    render json: {productsPartial: render_to_string('home/_products', locals: {showFirst: false}), layout: false, productCount: @products.count, lastProductID: @products.last.try(:id)}
  end



  private

  def product_params
    {limit: 36, title: params[:brand], product_type: params[:product_type], tag: params[:size], page: params[:page]}
  end

  def products_are_already_in_view?
    params[:last_prod_id].present? && params[:last_prod_id] == @products.last.id.to_s rescue false
  end
end
