require_relative 'board'
require_relative 'ship'
require_relative 'player'

class Game

  def welcome
    puts "Welcome to BATTLESHIP \n\n"
  end

  def main_menu
    puts "Enter p to play. Enter q to quit.\n\n"
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
# sleep(3)
    puts "Computer is placing ships on their grid...\n\n"
    # sleep(3)

    @computer_player = Player.new # moved this Useresque thing here bc not sure how to call otherwise
    @computer_player.create_computer_player

    puts "The computer's ships are on the grid.\n\n"
# sleep(3)
    puts "Now it's your turn.\n\n"

# sleep(3)
    @user_player = Player.new # moved this Useresque thing here bc not sure how to call otherwise
    @user_player.create_user_player

    puts "Your Cruiser is three units long.\n"
    puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"

    puts @user_board.render

    @user_player.ships.each do |ship|
      puts "\nEnter the coordinates for the #{ship.name} (#{ship.length} spaces):"
      print "> "
      user_coordinates = gets.chomp.upcase.split

      until @user_board.valid_placement?(ship, user_coordinates)
        puts "\nThose are invalid coordinates. Please try again:"
        print "> "
        user_coordinates = gets.chomp.upcase.split
      end

      @user_board.place(ship, user_coordinates)
    end
    user_turn
  end

  def user_turn(coordinate) # add optional parameter for testing specific method?
    puts "\n==========CURRENT COMPUTER BOARD=========="
    puts @computer_board.render
    puts "\n===========CURRENT USER BOARD==========="
    puts @user_board.render(true)
    puts "\nEnter the coordinate for your shot:"
    print "> "

    coordinate = gets.chomp.upcase

    if @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
      coordinate

    elsif !@computer_board.valid_coordinate?(coordinate)
      until @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
        puts "\nPlease enter a valid coordinate:"
        print "> "
        coordinate = gets.chomp.upcase
      end
      coordinate

    elsif @computer_board.valid_coordinate?(coordinate) && @computer_board.cells[coordinate].fired_upon?
      puts "\nYou have already fired upon this cell."

      until @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
        puts "\nPlease enter a valid coordinate:"
        print "> "
        coordinate = gets.chomp.upcase
      end
    coordinate
    end

    puts "\nFiring your missile..."
# sleep(3)

    @computer_board.cells[coordinate].fire_upon

    if @computer_board.cells[coordinate].render == "M"
      result = "miss."
    elsif @computer_board.cells[coordinate].render == "H"
      result = "hit!"
    elsif @computer_board.cells[coordinate].render == "X"
      result = "hit and sunk my #{@computer_board.cells[coordinate].ship.name}!"
    end

    puts "\nYour shot on #{coordinate} was a #{result}\n\n"
# sleep(3)

    if @computer_player.ships.all? { |ship| ship.sunk? }
      puts "You win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      @computer_player.computer_turn
    end
  end
  require 'pry'; binding.pry
@computer_player.computer_turn
end
