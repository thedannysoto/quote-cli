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
  
  def self.search_quotes(quote)
      if @@quotes_all.include?(quote) == false 
        quote = Quote.new(quote)
      end
  end
  
end