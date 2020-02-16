require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './quotes.rb'
require_relative './categories.rb'
require_relative './authors.rb'


class Scraper

  def self.scrape_author_by_letter(letter)
    base_html = "https://www.brainyquote.com"
    puts "Gathering letter #{letter}."
    scrape_page = base_html + "/authors/#{letter}"
    page1 = Nokogiri::HTML(open(scrape_page))
    num_pages = page1.css('li a')[-5].text
    num_pages = num_pages.to_i 
    page1.css('tbody tr').each do |item|
      name = item.css('a').text
      if Author.all.include?(name) == false 
        author = Author.new(name)
        author.name = name
      end 
      href = item.css('a').attr('href').value
      author.page = base_html + href
    end
    num = 2..num_pages
    num.each do |num|
      scrape_page = base_html + "/authors/#{letter}#{num}"
      page = Nokogiri::HTML(open(scrape_page))
      page.css('tbody tr').each do |item|
        name = item.css('a').text
        if Author.all.include?(name) == false 
        author = Author.new(name)
        author.name = name
      end
        href = item.css('a').attr('href').value
        author.page = base_html + href
      end
    end
  end

  def self.scrape_author_info(author)
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
    end
  end

  def self.scrape_quotes_by_author(author)
    category = []
    category_temp = []
    scribe = Author.all.find{|a|  a.name == author}
    page = Nokogiri::HTML(open(scribe.page))
    page.css('.m-brick').each do |block|
      quote1 = block.css('a')[0].text
      if @@quotes_all.include?(quote) == false 
        quote = Quote.new(quote)
      end 
      author1 = block.css('a')[1].text
      if @@all_authors.include?(author1) == false 
        author = Author.new(author1)
        quote.name = author
      else
        quote.name = Author.find(author1)
      end
      block.css('.kw-box').css('a').each do |c|
        cat = c.text
        category_temp << cat
        category_temp.each do |topic|
         category << Category.search_categories(topic)
        end
      quote.categories = category
    end
  end

  def self.scrape_quotes_by_topic(topic)
    topic_page = "http://brainyquote.com/topics/#{topic}-quotes"
    page = Nokogiri::HTML(open(topic_page))
    page.css('.m-brick').each do |block|
      quote_temp= []
      category_temp = []
      quote1 = block.css('a')[0].text
      if @@quotes_all.include?(quote) == false 
        quote = Quote.new(quote)
        quote_temp << quote
      else
        quote_temp << Quote.find(quote1)
      end 
      author1 = block.css('a')[1].text
      if @@all_authors.include?(author1) == false 
        author = Author.new(author1)
        quote.name = author
      else
        quote.name = Author.find(author1)
      end
      block.css('.kw-box').css('a').each do |c|
        category = []
        cat = c.text
        category_temp << cat
        category_temp.each do |topic|
         category << Category.search_categories(topic)
        end
      quote.categories = category  
      end
    end
  end
  
  def self.scrape_top_topics
    top_topics = []
    top_topics_temp = []
    topic_page = "http://www.brainyquote.com/topics"
    page = Nokogiri::HTML(open(topic_page))
    page.css('.bqLn').css('a').each do |f|
      top_topics_temp << f.text.strip!
    end
    top_topics_temp.delete(nil)
    top_topics_temp.each do |topic|
      top_topics << Category.search_categories(topic)
    end
    top_topics
  end
  end 
  
  def self.scrape_top_authors
    top_authors = []
    top_authors_temp = []
    author_page = "http://www.brainyquote.com/authors"
    page = Nokogiri::HTML(open(author_page))
    page.css(".authorContentName").each do |f|
      top_authors_temp << f.text
    end
    top_authors_temp.delete(nil)
    top_authors_temp.each do |author|
      top_authors << Author.search_authors(author)
    end
    top_authors
  end
end 


a = Author.get_authors_by_letter("a")






  

  
 
    
  






