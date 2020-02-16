require 'pry'
require 'terminal-table'
require 'colorize'

require_relative './quotes.rb'
require_relative './categories.rb'
require_relative './scraper.rb'

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
  
  def self.get_quotes_by_author(author)
    Scraper.scrape_quotes_by_author(author)
    arr = Quote.find_quote_by_author(author)
    table = Terminal::Table.new
      table.headings = ["Index", "Quote", "Author", "Categories"],
      table.rows = rows 
      arr.each_with_index do |quote, index|
        t << ["#{index}","#{quote.quote}", "#{quote.name}", "#{quote.categories}"]
        t << :separator
      end
      puts table
  end
end
