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
  
  
end