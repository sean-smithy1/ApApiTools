module Utils

  def self.internet?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

  def self.clear
    system('clear') || system('cls')
  end

  def self.artist_products_menu(products)
    line_items=[]
    products.each do |product|
      obj_p=Product.new(product)
      if obj_p.has_images
        obj_p.images.each do |img|
          line_items << { id: product[:id], name: product[:name], num_img: product[:master][:images].count, image_id: img[:id], file_name: img[:attachment_file_name] }
        end
      else
        line_items << { id: product[:id], name: product[:name ], num_img: product[:master][:images].count, image_id: '', file_name: 'NO ARTWORK' }
      end
    end
    line_items
  end

  def self.download(url, dir=nil)
    if dir.nil? || dir == ''
      dir = File.join(Dir.home,"Downloads")
    end

    file=File.basename(url)
    File.open(File.join(dir,file), "w") do |f|
      f.write(HTTP.get(url).body)
    f.close
    end
  end
end
