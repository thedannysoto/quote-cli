class CLI 
  
  def call 
    main_menu
  end
  
  def main_menu
    puts
    puts
    puts
    puts "_________________________________".colorize(:yellow)
    puts
    puts "           Quotes!  ".colorize(:yellow)
    puts
    puts "_________________________________".colorize(:yellow)
    puts
    puts
    puts "---------------------------------".colorize(:orange)
    puts
    puts "          Main Menu  ".colorize(:teal)
    puts "_________________________________".colorize(:teal)
    puts
    puts "1. Browse authors alphabetically.".colorize(:yellow)
    puts "2. View a random list of top authors to select from.".colorize(:yellow)
    puts "3. Browse by topic".colorize(:yellow)
    puts "4. View a randon list of top topics to select from".colorize(:yellow)
    puts
    puts
    puts "Please choose a number 1-4".colorize(:green)
    puts "You can type \'exit\' at anytime".colorize(:green)
    
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
        Author.get_authors_by_letter(letter)
      end
    end
    
    
  def self.display_authors_by_letter(letter)
    authors_list = Author.get_authors_by_letter(letter,start = 0, stop = 24)
    start = 0 
    stop = 24
    answer = 1
    while answer == 1  
      authors_list[start..stop].each_with_index do |author, index|
        puts "#{index + 1}| #{author.name}"
      end
      puts "Enter \'more\' for the next 25 authors.".colorize(:green)
           "Enter the author number in \'quotes\' to select the author and see quotes from that author.".colorize(:green)
           "Enter \'back\' to go back to the previous screen.".colorize(:green)
           "Enter \'letter\' to browse another letter.".colorize(:green)
           "Enter \'main\' to go back to the main menu.".colorize(:green)
           "Enter \'exit\' to exit the program".colorize(:green)
      a = gets.chomp
      if a.to_i > 0
        author = author_list[a-1].name
        CLI.display_quotes_by_author(author)
      case a 
      when a == "more"
        start += 25
        stop += 25
        answer == 1
      when a == "back"
        if start == 0 
          letter = ClI.choose_letter
          CLI.display_authors_by_letter(letter)
        else
          start -= 25
          stop -= 25
          answer == 1
        end
      when a == "letter"
        letter = ClI.choose_letter
        CLI.display_authors_by_letter(letter)
      when a == "main"
        CLI.main_menu
      when a == "exit"
        puts "Thanks for visiting. Goodbye.".colorize(:blue)
      else
        "Please choose from the following."
        "Enter \'more\' for the next 25 authors.".colorize(:green)
        "Enter the author number in \'quotes\' to select the author and see quotes from that author.".colorize(:green)
        "Enter \'back\' to go back to the previous screen.".colorize(:green)
        "Enter \'letter\' to browse another letter.".colorize(:green)
        "Enter \'main\' to go back to the main menu.".colorize(:green)
        "Enter \'exit\' to exit the program".colorize(:green)
      end
      answer
    end
  end
    
  
end
end
end

