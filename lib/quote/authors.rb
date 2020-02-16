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
      end
  end
  
  def self.authors_by_letter(letter)
    arr = []
    @@all_authors.each do |author|
      if author.name.startwith? "#{letter}"
        arr << author
      end
    end
  end
    

end