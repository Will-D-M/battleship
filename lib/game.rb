require_relative 'board'
require_relative 'ship'
require_relative 'player'

class Game

  attr_accessor :computer_player, :user_player

  def initialize
    @computer_player = nil
    @user_player = nil
  end

  def welcome
    puts "Welcome to BATTLESHIP \n\n"
  end

  def main_menu
    puts "Enter p to play. Enter q to quit. \n\n"
    print "> "
    menu_selection = gets.chomp.to_s.downcase

    until menu_selection == "p" || menu_selection == "q"
      puts "\nPlease enter a valid selection"
      print "> "
      menu_selection = gets.chomp.to_s.downcase
    end

    if menu_selection == "q"
      puts "\nGoodbye.\n\n\n"
      return
    else
      setup
    end
  end

  def setup
    puts "\n\n...game loading...\n\n"

    puts "Computer is placing ships on their grid...\n\n"

    @computer_player = Player.new
    @computer_player.create_computer_player

    puts "The computer's ships are on the grid.\n\n"
    puts "Now it's your turn.\n\n"

    @user_player = Player.new
    @user_player.create_user_player


    @user_player.user_ships.each do |ship|
    puts "\nEnter the coordinates for the #{ship.name} (#{ship.length} spaces):"
    print "> "
    user_coordinates = gets.chomp.upcase.split
      until @user_player.user_board.valid_placement?(ship, user_coordinates)
        puts "\nThose are invalid coordinates. Please try again:"
        print "> "
        user_coordinates = gets.chomp.upcase.split
      end
      @user_player.user_board.place(ship, user_coordinates)
    end
    user_turn
  end

  def user_turn
    puts "\n==========CURRENT COMPUTER BOARD=========="
    puts @computer_player.computer_board.render
    puts "\n===========CURRENT USER BOARD==========="
    puts @user_player.user_board.render(true)
    puts "\nEnter the coordinate for your shot:"
    print "> "

    coordinate = gets.chomp.upcase

    if @computer_player.computer_board.valid_coordinate?(coordinate) && !@computer_player.computer_board.cells[coordinate].fired_upon?
      coordinate

    elsif !@computer_player.computer_board.valid_coordinate?(coordinate)
      until @computer_player.computer_board.valid_coordinate?(coordinate) && !@computer_player.computer_board.cells[coordinate].fired_upon?
        puts "\nPlease enter a valid coordinate:"
        print "> "
        coordinate = gets.chomp.upcase
      end
      coordinate

    elsif @computer_player.computer_board.valid_coordinate?(coordinate) && @computer_player.computer_board.cells[coordinate].fired_upon?
      puts "\nYou have already fired upon this cell."
      until @computer_player.computer_board.valid_coordinate?(coordinate) && !@computer_player.computer_board.cells[coordinate].fired_upon?
        puts "\nPlease enter a valid coordinate:"
        print "> "
        coordinate = gets.chomp.upcase
      end
      coordinate
    end

    puts "\nFiring your missile..."
    # sleep(1.5)
    @computer_player.computer_board.cells[coordinate].fire_upon
    if @computer_player.computer_board.cells[coordinate].render == "M"
      result = "miss."
    elsif @computer_player.computer_board.cells[coordinate].render == "H"
      result = "hit!"
    elsif @computer_player.computer_board.cells[coordinate].render == "X"
      result = "hit and sunk my #{@computer_player.computer_board.cells[coordinate].ship.name}!"
    end

    puts "\nYour shot on #{coordinate} was a #{result}\n\n"
    if @computer_player.computer_ships.all? { |ship| ship.sunk? }
      puts "You win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      computer_turn
    end
  end

  def computer_turn
    @user_player.computer_turn
    if @user_player.user_ships.all? { |ship| ship.sunk? }
      puts "I win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      user_turn
    end
  end

end
