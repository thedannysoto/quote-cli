require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './authors.rb'
require_relative './quotes.rb'
require_relative './processing'

author_pages = []
names = []
occupations = []
base_html = "https://www.brainyquote.com"
author_az = "a".."z"
author_az.to_a
num = 2..19
num.to_a
puts "please wait while we gather the information."
author_az.each do |letter|
  puts "Gathering letter #{letter}."
  scrape_page = base_html + "/authors/#{letter}"
  page1 = Nokogiri::HTML(open(scrape_page))
  num_pages = page1.css('li a')[-5].text
  num_pages = num_pages.to_i 
  page1.css('tbody tr').each do |item|
    name = item.css('a').text
    author = Author.new(name)
    href = item.css('a').attr('href').value
    author.page = base_html + href
    author.occupation = item.css('td')[1].text.strip!
  end
  num = 2..num_pages
  num.each do |num|
    scrape_page = base_html + "/authors/#{letter}#{num}"
    page = Nokogiri::HTML(open(scrape_page))
    page.css('tbody tr').each do |item|
      name = item.css('a').text
      author = Author.new(name)
      href = item.css('a').attr('href').value
      author.page = base_html + href
      author.occupation = item.css('td')[1].text.strip!
    end
  end
end

def get_quotes_by_author(author)
  look_up_author = Author.all.find{|name| name == Author.name}
  quote_page = Nokogiri::HTML(open(look_up_author.page))
  

  
 
    
  






