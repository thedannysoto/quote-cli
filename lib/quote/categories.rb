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
  
  def self.search_categories(arr)
    arr.each do |c|
      if @@category_all.include?(c) == false 
        category = Category.new(c)
      end
    end
  end
  
end