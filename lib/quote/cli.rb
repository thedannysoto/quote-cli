require 'pry'
require 'colorize'

require_relative './quotes.rb'
require_relative './categories.rb'
require_relative './scraper.rb'
require_relative './authors.rb'


class CLI 
  
  def call 
    main_menu
  end
  
  def main_menu
    puts
    puts
    puts
    puts "       ----------------------------------".colorize(:yellow)
    puts
    puts "                   Quotes!  ".colorize(:yellow).colorize(:blink)
    puts
    puts "       ----------------------------------".colorize(:yellow)
    puts
    puts
    puts "       ----------------------------------".colorize(:cyan)
    puts
    puts "                  Main Menu  ".colorize(:cyan)
    puts "       ----------------------------------".colorize(:cyan)
    puts
    puts "       1. Browse authors alphabetically.".colorize(:yellow)
    puts "       2. View a random list of top authors to select from.".colorize(:yellow)
    puts "       3. Browse by topic".colorize(:yellow)
    puts "       4. View a randon list of top topics to select from".colorize(:yellow)
    puts
    puts
    puts "       Please choose a number 1-4".colorize(:green)
    puts "       You can type \'exit\' at anytime".colorize(:green)
    
    while true 
      input = gets.chomp!
      if input == "exit"
        puts "Thanks for visiting. Goodbye."
        break
      elsif input.to_i > 0 && input.to_i < 5
        @input = input.to_i
      else
        puts "Please enter a valid number or type \'exit\'"
      end
      case @input
      when 1
        letter = CLI.choose_letter
        CLI.display_authors_by_letter(letter, 0, 24)
      end
    end
  end
    
    
  def self.display_authors_by_letter(letter, start, stop)
    authors_list = Author.get_authors_by_letter(letter)
    answer = 1
    while true   
      authors_list[start..stop].each_with_index do |author, index|
        puts "#{index + 1}| #{author.name}"
      end
      puts
      puts
      puts "Enter 1 to select the author and see quotes from that author.".colorize(:green)
      puts "Enter 2 for the next 25 authors.".colorize(:green)
      puts "Enter 3 to go back to the previous screen.".colorize(:green)
      puts "Enter 4 to browse another letter.".colorize(:green)
      puts "Enter 5 to go back to the main menu.".colorize(:green)
      puts "Enter \'exit\' to exit the program".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thanks for visiting. Goodbye."
        break
      elsif input.to_i > 0 && input.to_i < 5
        @input = input.to_i
      else
        puts "Please enter a valid number or type \'exit\'"
      end
      case @input
      when 1
        puts "Enter author number."
        a = gets.strip!.to_i
        author = authors_list[start + a - 1].name
        CLI.display_quotes_by_author(author)
      when 2 
        start += 25
        stop += 25
        self.display_authors_by_letter(letter, start, stop)
      when 3
        if start == 0 
          letter = ClI.choose_letter
          CLI.display_authors_by_letter(letter)
        else
          start -= 25
          stop -= 25
          self.display_authors_by_letter(letter, start, stop) 
        end
      when 4
        letter = ClI.choose_letter
        CLI.display_authors_by_letter(letter)
      when 5
        CLI.main_menu
      end
    end
  end
  
  def self.choose_letter
    puts "                               Please choose a letter."
    puts 
    puts "A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z"
    letter = gets.downcase.strip!
  end
  
  def self.display_quotes_by_author(author, start=0, stop=24)
    quotes_list = Quote.get_quotes_by_author(author)
    answer = 1
    start = 0 
    stop = 9
    while answer == 1 
      if start > quotes_list.count
        puts "You've reached the end of the list."
      end
      quotes_list[start..stop].each_with_index do |quote, index|
        puts "#{index + 1}"
        puts "#{quote.quote}"
        puts 
        puts "#{quote.author.name}"
        puts "Categories:"
        quote.categories.each_with_index{|item, index| puts "#{index + 1}| #{item.category}"}
        puts "_________________________________________________________________________"
      end
      puts
      puts
      puts "Enter 1 to select a category from a particular quote.".colorize(:green)
      puts "Enter 2 for the next 10 quotes.".colorize(:green)
      puts "Enter 3 to go back to the previous screen.".colorize(:green)
      puts "Enter 4 to browse another letter.".colorize(:green)
      puts "Enter 5 to go back to the main menu.".colorize(:green)
      puts "Enter \'exit\' to exit the program".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thanks for visiting. Goodbye."
        break
      elsif input.to_i > 0 && input.to_i < 5
        @input = input.to_i
      else
        puts "Please enter a valid number or type \'exit\'"
      end
      case @input
      when 1
        puts "Enter quote number."
        a = gets.strip!.to_i
        puts "Enter category number from the quote."
        b = gets.strip!.to_i
        q = quotes_list[a - 1]
        top = q.categories[b - 1]
        CLI.display_quotes_by_category(top)
      when 2 
        start += 10
        stop += 10
        answer = 1
      when 3
        if start == 0 
          letter = ClI.choose_letter
          CLI.display_authors_by_letter(letter)
        else
          start -= 10
          stop -= 10
          answer = 1 
        end
      when 4
        letter = ClI.choose_letter
        CLI.display_authors_by_letter(letter)
      when 5
        CLI.main_menu
      end
      answer
    end
  end
  
  def self.display_quotes_by_category(topic, start = 0, stop = 9)
    topic_name = topic.category
    Scraper.scrape_quotes_by_topic(topic_name)
    quotes_list = Quote.all.find_all{|quote| quote.quote.include?(topic_name) || quote.quote.include?(topic_name.downcase)}
    answer = 1
      start = 0 
      stop = 9
    while answer == 1
      start
      stop
      quotes_list[start..stop].each_with_index do |quote, index|
        puts "#{index + 1}"
        puts "#{quote.quote}"
        puts 
        puts "#{quote.author.name}"
        puts "Categories:"
        quote.categories.each_with_index{|item, index| puts "#{index + 1}| #{item.category}"}
        puts "_________________________________________________________________________"
      end
      puts
      puts
      puts "Enter 1 to select a category from a particular quote.".colorize(:green)
      puts "Enter 2 for the next 10 quotes.".colorize(:green)
      puts "Enter 3 to go back to the previous screen.".colorize(:green)
      puts "Enter 4 to browse another letter.".colorize(:green)
      puts "Enter 5 to go back to the main menu.".colorize(:green)
      puts "Enter \'exit\' to exit the program".colorize(:green)
      input = gets.downcase.strip!
      if input == "exit"
        puts "Thanks for visiting. Goodbye."
        break
      elsif input.to_i > 0 && input.to_i < 5
        @input = input.to_i
      else
        puts "Please enter a valid number or type \'exit\'"
      end
      case @input
      when 1
        puts "Enter quote number."
        a = gets.strip!.to_i
        puts "Enter category number from the quote."
        b = gets.strip!.to_i
        q = quotes_list[a - 1]
        top = q.categories[b - 1]
        CLI.display_quotes_by_category(top)
      when 2 
        start += 25
        stop += 25
        answer = 1 
      when 3
        if start == 0 
          letter = ClI.choose_letter
          CLI.display_authors_by_letter(letter)
        else
          start -= 25
          stop -= 25
          answer = 1 
        end
      when 4
        letter = ClI.choose_letter
        CLI.display_authors_by_letter(letter)
      when 5
        CLI.main_menu
      end
    end
  end
  
end


