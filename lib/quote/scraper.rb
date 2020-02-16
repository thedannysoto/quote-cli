require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './authors.rb'
require_relative './quotes.rb'
require_relative './catagories.rb'


class Scraper

  def self.get_author_by_letter(letter)
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

  def self.get_author_info(author)
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

  def self.get_quotes_by_author(author)
    scribe = Author.all.find{|a|  a.name == author}
    page = Nokogiri::HTML(open(scribe.page))
    quote_arr = []
    page.css('.m-brick').each do |block|
      quote_temp= []
      category = []
      quote1 = block.css('a')[0].text
      Quote.search_quotes(quote1)
      quote_temp << quote1
      author1 = block.css('a')[1].text
      Author.search_authors(author1)
      quote_temp << author1
      block.css('.kw-box').css('a').each do |c|
        cat = c.text
        category << cat
      end
      Category.search_categories(category)
      quote_temp << category
      quote_arr << quote_temp
    end
    quote_arr 
  end

  def self.get_quotes_by_topic(topic)
    quote_arr = []
    topic_page = "http://brainyquote.com/topics/#{topic}-quotes"
    page = Nokogiri::HTML(open(topic_page))
    page.css('.m-brick').each do |block|
      quote_temp= []
      category = []
      quote1 = block.css('a')[0].text
      Quote.search_quotes(quote1)
      quote_temp << quote1
      author1 = block.css('a')[1].text
      Author.search_authors(author1)
      quote_temp << author1
      block.css('.kw-box').css('a').each do |c|
        cat = c.text
        category << cat
      end
      Category.search_categories(category)
      quote_temp << category
      quote_arr << quote_temp
    end
    quote_arr
  end
  
  def self.Get_top_topics
    top_topics_arr = []
    topic_page = "http://www.brainyquote.com/topics"
    page = Nokogiri::HTML(open(topic_page))
    page.css('.bqLn').css('a').each do |f|
      top_topics_arr << f.text.strip!
    end
    top_topics_arr.delete(nil)
    Category.search_categories(top_topics_arr)
    top_topics_arr
  end 
    
end 

a = Scraper.Get_top_topics
binding.pry


  

  
 
    
  






