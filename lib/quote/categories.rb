require 'pry'
require 'terminal-table'
require 'colorize'

require_relative './quotes.rb'
require_relative './categories.rb'
require_relative './scraper.rb'

class Category
  attr_accessor :category
  
  @@category_all = []
  
  def initialize(cat)
    @category = cat
    @@category_all << self
  end
  
  def self.all 
    @@category_all 
  end 
  
  def self.find_category(name)
    @@category_all.select{|a| a.name == name}
  end
  
  def self.search_categories(category)
      if @@category_all.include?(category) == false 
        category = Category.new(category)
      else
        category = Category.find_category(category)
      end
    end
    category
  end
  
  def self.get_top_topics
    arr = Scraper.scrape_top_topics
    table = Terminal::Table.new
      table.headings = ["Number", "Topic"],
      table.rows = rows
      arr.each_with_index do |topic, index|
        t << ["#{index + 1}", "#{topic.category}"]
        t << :separator
      end
      puts table
  end
