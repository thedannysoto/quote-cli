require 'pry'
require 'colorize'

require_relative './quotes.rb'
require_relative './categories.rb'
require_relative './scraper.rb'
require_relative './authors.rb'

class Quote
  attr_accessor :quote, :categories, :author 
  
  @@quotes_all = []
  
  def initialize(quote)
    @quote = quote
    @@quotes_all << self
  end
  
  def self.all
    @@quotes_all
  end
  
  def self.find_quote(quote)
    @@quotes_all.select{|a| a.quote == quote}
  end
  
  def self.find_quote_by_author(author)
    arr = []
    @@quotes_all.each do |a| 
      if a.author == author
        arr << a
      end
    end
  end
  
  def self.search_quotes(quote)
      if @@quotes_all.include?(quote) == false 
        quote1 = Quote.new(quote)
      else
        quote1 = Category.find_category(quote)
      end
    quote1
  end
  
  def self.get_quotes_by_author(author)
    quote_arr = []
    Scraper.scrape_quotes_by_author(author)
    quote_arr = Quote.find_quote_by_author(author)
  end
end
