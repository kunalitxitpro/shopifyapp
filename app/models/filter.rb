class Filter < ApplicationRecord
  belongs_to :product_setting
  validates :title, uniqueness: true

  SQL_FILTERS = {
    'sweatshirts-hoods' => FilterSql.new.sweatshirts,
    'jackets-coats' => FilterSql.new.jackets,
    'shirts' => FilterSql.new.shirts,
    't-shirts' => FilterSql.new.t_shirts,
    'polo-shirts' => FilterSql.new.polo_shirts,
    'football-shirts' => FilterSql.new.football_shirts,
    'rugby-tops' => FilterSql.new.rugby_tops,
    'party-shirts' => FilterSql.new.party_shirts,
    'tracksuit-bottoms' => FilterSql.new.tracksuit_bottoms,
    'shorts' => FilterSql.new.shorts,
    'tracksuits' => FilterSql.new.tracksuits,
    'footwear' => FilterSql.new.footwear,
    'accessories' => FilterSql.new.accessories,
    'mystery-box' => FilterSql.new.mystery_box,
    'vests' => FilterSql.new.vests,
    'girls' => FilterSql.new.girls,
    'new-in' => FilterSql.new.new_in,
    'adidas-archive' => FilterSql.new.adidas_archive,
    'stone-island' => FilterSql.new.stone_island,
    'tommy-hilfiger-archive' => FilterSql.new.tommy_hilfiger_archive,
    'sale' => FilterSql.new.sale,
    'clothing' => FilterSql.new.clothing,
    'our-picks' => FilterSql.new.our_picks,
    '20-off-1' => FilterSql.new.twenty_off,
    'sunglasses' => FilterSql.new.sunglasses,
  }

  COLLECTION_TITLES = {
    'jackets-coats' => 'Jackets & Coats',
    'sweatshirts-hoods' => 'Sweatshirts & Hoods',
    'polo-shirts' => 'Polo Shirts',
    'football-shirts' => 'Football Shirts',
    'rugby-tops' => 'Rugby Tops',
    'party-shirts' => 'Party Shirts',
    'tracksuit-bottoms' => 'Tracksuit Bottoms',
    'mystery-box' => 'Mystery Box',
    'new-in' => 'New In',
    'adidas-archive' => 'Adidas Archive',
    'stone-island' => 'Stone Island',
    'tommy-hilfiger-archive' => 'Tommy Hilfiger Archive',
    'our-picks' => 'Our Picks',
    '20-off-1' => '20% OFF',
    'sunglasses' => 'Sunglasses'
  }

  scope :brands,  -> { where('filter_type = 0 AND (position IS NULL OR position != -1)').order(position: :asc )}
  scope :sizes,   -> { where('filter_type = 1 AND (position IS NULL OR position != -1)').order(position: :asc )}
  scope :types,   -> { where('filter_type = 2 AND (position IS NULL OR position != -1)').order(position: :asc )}
  scope :colours, -> { where('filter_type = 3 AND (position IS NULL OR position != -1)').order(position: :asc )}

  scope :admin_brands,  -> { where('filter_type = 0').order(position: :asc )}
  scope :admin_sizes,   -> { where('filter_type = 1').order(position: :asc )}
  scope :admin_types,   -> { where('filter_type = 2').order(position: :asc )}
  scope :admin_colours, -> { where('filter_type = 3').order(position: :asc )}

  enum filter_type: {
    prod_brand: 0,
    prod_size: 1,
    prod_type: 2,
    prod_colour: 3
  }

  def self.sql_for_string(string)
    SQL_FILTERS[string].present? ? SQL_FILTERS[string] : FilterSql.new.for_brand(string)
  end

  def self.converted_url_strings(string)
    if URI_FILTERS[string].present?
      URI_FILTERS[string]
    else
      string
    end
  end

  def self.title_string_for_collection(string)
    if COLLECTION_TITLES[string].present?
      COLLECTION_TITLES[string]
    else
      string
    end
  end

end
