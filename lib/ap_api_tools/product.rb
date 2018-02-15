class Product

#Instance

  def initialize(p, id=nil)
    @product = p
    if id
      @product = get_product(id)
    end
  end

  def images
    @product[:master][:images]
  end
  
  def has_images
    @product[:master][:images].count > 0
  end

private

  def get_product(id)
   # Get Product
  end
  
  def self.get_products(artist_id, page_no=1)
    puts "Getting Products: #{page_no}"
    product_return=HTTP.headers(
      :accept => "application/json",
      'X-Spree-Token': "#{ApApiTools::API_KEY}"
    )
    .get("#{ApApiTools::HOST}/products/?q[taxon_ids)=artist_id&page=#{page_no}")
    
    JSON.parse(product_return.body, symbolize_names: true)
  end
end