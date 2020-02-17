require 'pry'
require 'terminal-table'
require 'colorize'

require_relative './quotes.rb'
require_relative './categories.rb'
require_relative './scraper.rb'

class Author 
  
  @@all_authors = []

  attr_accessor :name, :nationality, :occupation, :birth_date, :death_date, :page

  def initialize(name)
  @name = name
    @@all_authors << self
  end

  def self.all
    @@all_authors 
  end

  def self.unique 
    @@all_authors.uniq!
  end

  def self.find_author(name)
    @@all_authors.select{|a| a.name == name}
  end
  
  def self.search_authors(name)
      if @@all_authors.include?(name) == false 
        author = Author.new(name)
        Scraper.scrape_author_info(name)
        author
      else
        author = Author.find_author(name)
        author
      end
  end
  
  def self.find_authors_by_letter(letter)
    a = letter.upcase!
    arr = []
    @@all_authors.each do |author|
      if author.name.start_with? "#{letter}"
        arr << author
      end
    end
    arr
  end
  
  def self.get_authors_by_letter(letter)
    arr = []
    Scraper.scrape_author_by_letter(letter)
    Author.find_authors_by_letter(letter).each{|author| arr << author}
    arr.repeated_combination(25)
  end 
  
  def self.get_top_authors
    arr = Scraper.scrape_top_authors
    arr.each do |author|
      Scraper.scrape_author_info(author)
    end
    table = Terminal::Table.new
      table.headings = ["number", "Author", "Occupation", "Nationality", "Life-span"]
      table.rows = rows
      arr.each_with_index do |author, index|
        t << ["#{index + 1}", "#{author.name}", "#{author.occupation}", "#{author.nationality}", "#{author.birth_date}-#{death_date}"]
        t << :separator
      end
    puts table
  end
end 
