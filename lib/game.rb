require_relative 'board'
require_relative 'ship'
require_relative 'player'

class Game

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
      # sleep(3)
      puts "Computer is placing ships on their grid...\n\n"

      @comp_cruiser = Ship.new("Cruiser", 3)
      @comp_submarine = Ship.new("Submarine", 2)

      @computer_board = Board.new
      @computer_board.add_cells

      @computer_player = Player.new

      @computer_player.add_ships(@comp_cruiser)
      @computer_player.add_ships(@comp_submarine)

      @computer_player.ships.each do |ship|
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
        until @computer_board.valid_placement?(ship, random_coordinates)
          random_coordinates = @computer_board.cells.keys.sample(ship.length)
        end
        @computer_board.place(ship, random_coordinates)
      end
      # sleep(3)
      puts "The computer's ships are on the grid.\n\n"
      # sleep(2)
      puts "Now it's your turn.\n\n"

      @user_board = Board.new
      @user_board.add_cells

      @user_cruiser = Ship.new("Cruiser", 3)
      @user_submarine = Ship.new("Submarine", 2)

      @user_player = Player.new

      @user_player.add_ships(@user_cruiser)
      @user_player.add_ships(@user_submarine)
      #render
      # sleep(3)
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

  def user_turn
    puts "\n==========CURRENT COMPUTER BOARD=========="
    puts @computer_board.render
    puts "\n===========CURRENT USER BOARD==========="
    puts @user_board.render(true)
    puts "\nEnter the coordinate for your shot:"
    print "> "

    coordinate = gets.chomp.upcase

    if @computer_board.valid_coordinate?(coordinate) == true && !@computer_board.cells[coordinate].fired_upon?
      coordinate

    elsif !@computer_board.valid_coordinate?(coordinate)
      until @computer_board.valid_coordinate?(coordinate) == true && !@computer_board.cells[coordinate].fired_upon?
        puts "\nPlease enter a valid coordinate:"
        print "> "
        coordinate = gets.chomp.upcase
      end
      coordinate

    elsif @computer_board.valid_coordinate?(coordinate) == true && @computer_board.cells[coordinate].fired_upon?
      puts "\nYou have already fired upon this cell."
      until @computer_board.valid_coordinate?(coordinate) == true && !@computer_board.cells[coordinate].fired_upon?
        puts "\nPlease enter a valid coordinate:"
        print "> "
        coordinate = gets.chomp.upcase
      end
      coordinate

    end

    puts "\nFiring your missile..."
    # sleep(1.5)
    @computer_board.cells[coordinate].fire_upon
    if @computer_board.cells[coordinate].render == "M"
      result = "miss."
    elsif @computer_board.cells[coordinate].render == "H"
      result = "hit!"
    elsif @computer_board.cells[coordinate].render == "X"
      result = "hit and sunk my #{@computer_board.cells[coordinate].ship.name}!"
    end

    puts "\nYour shot on #{coordinate} was a #{result}\n\n"

    if @computer_player.ships.all? { |ship| ship.sunk? }
      puts "You win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      computer_turn
    end
  end
    # sleep(1.5)
  def computer_turn
    puts "Firing my missile..."
    # sleep(1.5)
    comp_coordinate = @user_board.cells.keys.sample(1).join
      until @user_board.valid_coordinate?(comp_coordinate) == true && !@user_board.cells[comp_coordinate].fired_upon?
        comp_coordinate = @user_board.cells.keys.sample(1).join
      end
    comp_coordinate

    @user_board.cells[comp_coordinate].fire_upon
    if @user_board.cells[comp_coordinate].render == "M"
      result = "miss."
    elsif @user_board.cells[comp_coordinate].render == "H"
      result = "hit!"
    elsif @user_board.cells[comp_coordinate].render == "X"
      result = "hit and sunk your #{@user_board.cells[comp_coordinate].ship.name}!"
    end

    puts "\nMy shot on #{comp_coordinate} was a #{result}\n\n"

    if @user_player.ships.all? { |ship| ship.sunk? }
      puts "I win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      user_turn
    end

  end

end
