class TestAdminsController < ApplicationController
  def index
    @products = Product.all.limit(10)
    @vendor_array = ['Adidas', 'American Sports Teams','Aquascutum','Armani','Asics', 'Avirex', 'Barbour', 'Belstaff', 'Best Company', 'Burberry', 'Nike']
    @size_array = ['L', 'M', 'S', "Women's", 'XL', 'XS', 'XXL', 'XXS']
    @product_type = ['Bags', 'dress', 'Football shirts', 'Hockey Top', 'Jackets & Coats', 'Jeans', 'Party Shirts', 'Polo Shirts', 'Rugby Tops', 'Shirts', 'Shorts', 'Skirts', 'Sweatshirts & Hoods', 'T-Shirts', 'Tracksuit', 'Tracksuit Bottoms', 'Trainers', 'Vests', 'Wholesale']
    @price_ranges = ['0 - 31', '31 - 70', '71 - 90', '91 - 110']
  end
end
