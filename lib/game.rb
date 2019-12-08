require_relative 'board'
require_relative 'ship'
require_relative 'player'

  def main_menu
    3.times{puts "\n"}
    puts "Welcome to BATTLESHIP \n"
    puts "Enter p to play. Enter q to quit. \n\n"
    print "> "
    menu_selection = gets.chomp.to_s.downcase

    until menu_selection == "p" || menu_selection == "q"
      puts "Please enter a valid selection"
      print "> "
      menu_selection = gets.chomp.to_s.downcase
    end

    if menu_selection == "q"
      puts "\n\nGoodbye.\n\n\n"
      return
    else
      setup
    end
  end

  def setup
      puts "\n\n...game loading...\n\n\n"
      # sleep(3)
      puts "Computer is placing ships on their grid...\n\n"

      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)

      @computer_board = Board.new
      @computer_board.add_cells

      @computer_player = Player.new

      @computer_player.add_ships(@cruiser)
      @computer_player.add_ships(@submarine)

      @computer_player.ships.each do |ship|
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
        until @computer_board.valid_placement?(ship, random_coordinates)
          random_coordinates = @computer_board.cells.keys.sample(ship.length)
        end

        @computer_board.place(ship, random_coordinates)
      end
      # sleep(3)
      puts "The computer's ships are on the grid.\n\n\n"
      # sleep(2)
      puts "Now it's your turn."

      @user_board = Board.new
      @user_board.add_cells

      @user_player = Player.new

      @user_player.add_ships(@cruiser)
      @user_player.add_ships(@submarine)
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
      puts "\n"

    end
    turn
  end

  def turn
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

    puts "\nYour shot on #{coordinate} was a #{result}"
    # sleep(1.5)

    puts "\nFiring my missile..."
    # sleep(1.5)

    @user_board.cells[coordinate].fire_upon
    if @user_board.cells[coordinate].render == "M"
      result = "miss."
    elsif @user_board.cells[coordinate].render == "H"
      result = "hit!"
    elsif @user_board.cells[coordinate].render == "X"
      result = "hit and sunk your #{@user_board.cells[coordinate].ship.name}!"
    end

    puts "\nMy shot on #{coordinate} was a #{result}"
    # sleep(1.5)

  end

main_menu
