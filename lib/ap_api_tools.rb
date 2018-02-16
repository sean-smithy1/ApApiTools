#!usr/bin/env ruby
require_relative "ap_api_tools/version"
require_relative 'ap_api_tools/utils'
require_relative 'ap_api_tools/product'
require_relative 'ap_api_tools/artist'

module ApApiTools
  require 'json'
  require 'http'
  require 'open-uri'


  HOST = ENV['AP_API_HOST']
  API_KEY = ENV['AP_API_KEY']

  def self.prompt
    puts
    puts "To download use comma delimited seq numbers eg: 1,3,5 or (A)ll"
    puts "To change pages (N)ext or (P)revious"
    print "Select : "
    @select=gets.chomp.to_s
  end

loop do

  Utils.clear

  if Utils.internet? == false
    puts "Internet is required"
    exit
  end

  # Menu
  puts "This Utility will download Images by type for an Artist"
  puts "-------------------------------------------------------"
  puts

  artists = Artist.new
  artists.list.each do |a|
    puts "#{a[:seq]}    #{a[:name]}"
  end
  
  print "\nSelect Artist (1..) : "
  a_select=gets.to_i
  
  puts
  puts "This Artist has this list of artworks"
  puts "-"*38

  page=1
  
  loop do
  artworks=Product.get_products(a_select, page)
  printf("%-3s %-3s %-20s %3s %-20s \n\n", 'Seq', 'ID', 'Name', "I-ID", "Name")

  i=1
  Utils.artist_products_menu(artworks[:products]).each do |value|
    printf("%-3s %-3s %-20s %-3s %-20s \n", i.to_s, value[:id].to_s, value[:name], value[:image_id].to_s, value[:file_name] )
    i+=1
  end
  puts "page: #{artworks[:current_page].to_s} of #{artworks[:pages].to_s}"

    loop do
      prompt
      case @select.downcase
      when "p"
        if artworks[:current_page]-1 == 0
          puts "** Already at first page"
        else  
          page=artworks[:current_page]-1
          break
        end
      when "n"
        if artworks[:current_page]+1 > artworks[:pages]
          puts "** Already at last page"
        else  
          page=artworks[:current_page]+1
          break
        end
      when "a"
        puts
        print "Directory (default Home\\Downloads) : "
        directory=gets.chomp
        artworks[:products].each do |art|
          p=Product.new(art)
          # Test for images
          if p.has_images
            p.images.each do |img|
              # All Artworks
              Utils.download(img[:product_url], directory)
            end
          end
        end
        break
      else
        # Download Numbered Items
        puts
        print "Directory (default Home\\Downloads) : "
        directory=gets.chomp
        to_print = @select.split(',').map { |e| e.chomp.to_i }
        to_print.each do |product_seq|
          p=Product.new(artworks[:products][product_seq-1])
          if p.has_images
            p.images.each do |img|
              # All Artworks
              Utils.download(img[:product_url], directory)
            end
          end
        end
        break
      end #Case
    end #Loop Case
  end #Loop Outer

  print 'Quit (Y/N) :'
  quit=gets.chomp.to_s
  
  break if quit.downcase == 'y'

end #Loop

end
