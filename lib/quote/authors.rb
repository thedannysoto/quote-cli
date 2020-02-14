class Author 

@@all_authors = []

attr_accessor :name, :occupation, :birth_date, :death_date, :page

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



end