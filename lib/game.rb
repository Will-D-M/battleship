# game runner file
require_relative 'board'
# require_relative 'user'


def main_menu
  3.times{puts "\n"}
  puts "Welcome to BATTLESHIP \n"
  puts "Enter p to play. Enter q to quit. \n\n"
  print "> "
  menu_selection = gets.chomp.to_s.downcase

  until menu_selection == "p" || menu_selection == "q" do
    puts "Please enter a valid selection"
    print "> "
    menu_selection = gets.chomp.to_s.downcase
  end

  if menu_selection == "q"
    puts "\n\nGoodbye.\n\n\n"
    return
  elsif menu_selection == "p"
      puts "\n\n...game loading...\n\n\n"
      sleep(3)
      # @board.render
      # computer = User.new("Computer")
      # player = User.new("Player")
      # computer.board.place
      puts "Computer is placing ships on their grid...\n"
      sleep(3)
      puts "The computer's ships are on the grid.\n\n\n"
      sleep(2)
      puts "Now it's your turn. You have two ships.\n\n\n"
      sleep(3)
      puts "Your Cruiser is three units long.\n"
      puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"
      puts "Press Enter/Return To Continue"
      continue = gets
      print "> "
        if continue == "\n"
          puts "\n\nGreat!\n\n"
        end
      puts "Your Submarine is two units long.\n\n"
      sleep(2)
      puts "For example:\n\nA2 A3\nor\nB1 C1\n\n\n"
      puts "Ready?\n\n"
      puts "Press Enter/Return To Continue"
      continue = gets
      print "> "
        if continue == "\n"
          puts "\n\nGreat!\n\n"
        end
      puts "Enter the squares for the Cruiser (3 spaces):"
      print "> "

      # player_cruiser = gets.chomp.to_s
      # if input chars validate?
        # if @board.cells.keys.include?(player_cruiser)
          # @board.place(cruiser, player_cruiser)
        # else
      # else puts "Please input valid spaces like the example..."

    end
  end

main_menu
