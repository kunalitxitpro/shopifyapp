class SyncProductsJob < ApplicationJob
  queue_as :default

  def perform
    shop = Shop.first # or find specific shop to pull products from
    all_product_ids = []
    if shop.present?
      shop.with_shopify_session do
        total_products = ShopifyAPI::Product.count()
        total_prods_to_loop = (total_products.to_f/250).round
        total_prods_to_loop.times do |page|
          page = page + 1
          products = ShopifyAPI::Product.find(:all, params: {page: page, limit: 250})

          products.each do |prod|
            if prod.published_at.present?
              compare_price = prod.variants.first.compare_at_price.to_f rescue nil
              set_prod = Product.where(shopify_id: prod.id).first
              new_prod = set_prod.present? ?  update_product(prod, compare_price, set_prod) : new_product(prod, compare_price)
              new_prod.save
              add_sizes(prod, new_prod)
              all_product_ids << prod.id
            else
              set_prod = Product.where(shopify_id: prod.id).first
              set_prod.destroy if set_prod.present?
            end
          end
        end
      end
      Product.dedupe
      Product.where.not(shopify_id: all_product_ids.flatten).destroy_all

      Product.pluck(:vendor).uniq.each do |vendor|
        Filter.create(title: vendor, product_setting_id: ProductSetting.last.id, filter_type: 0) if Filter.find_by_title(vendor).nil?
      end

      Product.pluck(:product_type).uniq.reject(&:blank?).uniq.each do |pt|
        Filter.create(title: pt, product_setting_id: ProductSetting.last.id, filter_type: 2) if Filter.find_by_title(pt).nil?
      end

      Size.pluck(:title).uniq.each do |size|
        Filter.create(title: size, product_setting_id: ProductSetting.last.id, filter_type: 1) if Filter.find_by_title(size).nil?
      end

      SyncCollectionsJob.perform_later
    end
  end

  def new_product(prod, compare_price)
    Product.new(
      title: prod.title,
      vendor: prod.vendor,
      tags: prod.tags,
      first_image_url: prod.image.try(:src),
      second_image_url: prod.images.last.try(:src),
      price: prod.variants.first.price.to_f,
      quantity: prod.variants.sum{|p| p.inventory_quantity},
      compare_at_price: compare_price,
      shopify_id: prod.id,
      product_type: prod.product_type,
      shopify_created_at: prod.created_at.to_datetime,
      slug_url: prod.handle,
      colour: colour_of_product(prod),
      body_html: prod.body_html
    )
  end

  def update_product(prod, compare_price, set_product_record)
    set_product_record.title = prod.title
    set_product_record.vendor = prod.vendor
    set_product_record.tags = prod.tags
    set_product_record.first_image_url = prod.image.try(:src)
    set_product_record.second_image_url = prod.images.last.try(:src)
    set_product_record.price = prod.variants.first.price.to_f
    set_product_record.quantity = prod.variants.sum{|p| p.inventory_quantity}
    set_product_record.compare_at_price = compare_price
    set_product_record.product_type =  prod.product_type
    set_product_record.shopify_created_at = prod.created_at.to_datetime
    set_product_record.slug_url = prod.handle
    set_product_record.colour = colour_of_product(prod)
    set_product_record.body_html = prod.body_html
    return set_product_record
  end

  def colour_of_product(product)
    colour = product.tags.split(',').select{|p| p.include?("Colour")}[0].split('_').last.titleize rescue nil
  end

  def add_sizes(product, record)
    product.variants.each do |size|
      newsize = Size.find_or_create_by(shopify_id: size.id)
      newsize.title = size.title
      newsize.inventory_quantity = size.inventory_quantity
      newsize.product_id = record.id
      newsize.save
    end
  end
end
