class FilterSql

  def initialize
  end

  def sweatshirts
    "product_type = 'Sweatshirts & Hoods' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def jackets
    "product_type = 'Jackets & Coats' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def new_in
    "tags LIKE '%new-arrivals%' and vendor != 'True' and vendor != 'True Collective' and vendor != 'Faces'"
  end

  def shirts
    "product_type = 'Shirts' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def t_shirts
    "product_type = 'T-Shirts' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def polo_shirts
    "product_type = 'Polo Shirts' and quantity > 0"
  end

  def football_shirts
    "product_type = 'Football Shirts' and quantity > 0"
  end

  def rugby_tops
    "product_type = 'Rugby Tops' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def party_shirts
    "product_type = 'Party Shirts' and quantity > 0"
  end

  def tracksuit_bottoms
    "product_type = 'Tracksuit Bottoms' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def shorts
    "product_type = 'Shorts' and quantity > 0 and tags LIKE '%for_guys%'"
  end

  def tracksuits
    "product_type = 'Tracksuit' and quantity > 0"
  end

  def footwear
    "tags LIKE '%footwear%' and product_type = 'Trainers' or product_type = 'Trainer Accessories'"
  end

  def accessories
    "product_type = 'Jewellery' or product_type = 'Sunglasses' or product_type = 'Trainer Accessories' or product_type = 'Watches' or product_type = 'Sunglasses' or product_type = 'Rings' or product_type = 'Scarfs' or product_type = 'Hats' or product_type = 'Bags'"
  end

  def mystery_box
    "product_type = 'Mystery Box'"
  end

  def vests
    "product_type = 'Vests' and quantity > 0"
  end

  def girls
    "tags LIKE '%for_girls%' and quantity > 0"
  end

  def adidas_archive
    "tags LIKE '%Adidas-archive%'"
  end

  def stone_island
    "vendor = 'Stone Island'"
  end

  def tommy_hilfiger_archive
    "tags LIKE '%tommy-archive%'"
  end

  def sale
    "compare_at_price > 0 and quantity > 0 and (product_type != 'Mystery Box' or product_type != 'Lucky Dip' or product_type != 'Supreme' or product_type != 'Stone Island' or product_type != 'Palace')"
  end

  def clothing
    product_type_query(['Bags', 'Bedspreads', 'Bracelets', 'Crochet Tops', 'Festival T-Shirts', 'Jerga Hoodies', 'Jewellery', 'Lucky Dip Shirts', 'Mystery Box', 'Party Shirts', 'Earrings', 'Scarfs', 'Skirts', 'Socks', 'Sunglasses', 'Trainer Accessories', 'TRUE Hoodies', 'TRUE T-shirts', 'Watches', 'Hats', 'Hat', 'Trainers', 'Rings'])
  end

  def our_picks
    "vendor != 'Festival Rags' and quantity > 0 and tags LIKE '%featured%'"
  end

  def twenty_off
    "vendor != 'Stone Island' AND vendor != 'Supreme' AND vendor != 'Palace'"
  end

  def sunglasses
    "product_type = 'Sunglasses'"
  end

  def for_brand(brand)
    "vendor = '#{brand}' and quantity > 0 and product_type != 'Auctions'"
  end

  private

  def product_type_query(product_types)
    query = []
    product_types.each do |pt|
      query << "product_type != '#{pt}'"
    end
    return query.join(" AND ")
  end
end
