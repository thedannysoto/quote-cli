require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './authors.rb'
require_relative './quotes.rb'
require_relative './catagories.rb'

author_pages = []
names = []
occupations = []


def author_look_up_by_letter(letter)
  base_html = "https://www.brainyquote.com"
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
    end
  end
end

def author_info(author)
  scribe = Author.all.find{|a|  a.name == author}
  page = Nokogiri::HTML(open(scribe.page))
  author_info = page.css('.subnav-below-p').text
  auth_arr = author_info.strip!.split(" ")
  if auth_arr.count == 7
    scribe.nationality = auth_arr[0]
    scribe.occupation = auth_arr[2]
    b_day = "#{auth_arr[4]} #{auth_arr[5]}, #{auth_arr[6]}"
    scribe.birth_date = b_day
  elsif auth_arr.count == 8
    scribe.nationality = auth_arr[0]
    scribe.occupation = auth_arr[2]
    b_day = "#{auth_arr[3]} #{auth_arr[4]}"
    scribe.birth_date = b_day
    d_day = "#{auth_arr[6]} #{auth_arr[7]}"
    scribe.death_date = d_day
  elsif auth_arr.count == 10 
    scribe.nationality = auth_arr[0]
    scribe.occupation = auth_arr[2]
    b_day = "#{auth_arr[3]} #{auth_arr[4]}, #{auth_arr[5]}"
    scribe.birth_date = b_day
    d_day = "#{auth_arr[7]} #{auth_arr[8]}, #{auth_arr[9]}"
    scribe.death_date = d_day
  else
    puts "You screwed up Chris fix it."
  end
end

def quotes_by_author(author)
  scribe = Author.all.find{|a|  a.name == author}
  page = Nokogiri::HTML(open(scribe.page))
  page.css('.m-brick').each do |block|
    category = []
    quote1 = block.css('a')[0].text
    quote = Quote.new(quote1)
    quote.author = scribe
    author_arr_count = scribe.name.split(' ').count
    s = block.css('a').text
    s_arr = s.scan(/[A-Z][a-z]+/)
    binding.pry
  end
end

author_look_up_by_letter("a")
a = quotes_by_author("Aesop")


  

  
 
    
  






