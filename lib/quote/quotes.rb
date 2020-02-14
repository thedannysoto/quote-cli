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
  
end