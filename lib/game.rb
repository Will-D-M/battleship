require_relative 'ship'
require_relative 'board'
require_relative 'user'


class Game
  attr_reader :player, :player_move

  def intialize
    @player = player
    @player_move = player_move
  end

  def main_menu
    3.times{puts "\n"}
    puts "### Welcome to BATTLESHIP ###\n"
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
      require 'pry'; binding.pry
      # @board.render
      # computer = User.new(false)
      # computer.user.computer_player_start
      # player = User.new
      puts "Computer is placing ships on their grid...\n\n\n"
      sleep(3)
      puts "The computer's ships are on the grid.\n\n\n"
      sleep(2)
    end
  end

  def player_instructions
    puts "Now it's your turn. You have two ships.\n\n\n"
    sleep(3)
    puts "Your Cruiser is three units long.\n"
    puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"
    puts "Press Enter/Return To Continue"
    continue = gets

      if continue == "\n"
        puts "\n\nGreat!\n\n"
      end

    puts "Your Submarine is two units long.\n\n"
    sleep(2)
    puts "For example:\n\nA2 A3\nor\nB1 C1\n\n\n"
    puts "Ready?\n\n"
    puts "Press Enter/Return To Continue"
    continue = gets

      if continue == "\n"
        puts "\n\nGreat!\n\n"
      end
  end

  # def battleship_simulator
      # This is where the game play lives
  # end
end
