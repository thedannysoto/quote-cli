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
      else
        author = Author.find_author(name)
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
    author_arr = []
    Scraper.scrape_author_by_letter(letter)
    start = 0 
    stop = 24
    answer = 1
    while answer == 1  
      Author.all[start..stop].each_with_index do |author, index|
        puts "#{index + 1}| #{author.name}"
      end
      puts "Would you like to see 25 more? /n Enter 1 for more or 2 to stop."
      a = gets.chomp
      if a == "1"
        start += 25
        stop +=25
        answer = 1
      elsif a != "1"
        puts "You have stopped."
        answer = 2
      end
      answer
    end

    
  end 
  
  def self.get_top_authors
    arr = Scraper.scrape_top_authors
    
  end
end 



