class Player
  attr_reader :computer_player, :computer_board, :user_player, :user_board, :ships

  def initialize # Not sure these should be nil values... they should just equal each other.
    @computer_player = nil
    @computer_board = nil
    @user_player = nil
    @user_board = nil
    @ships = []
  end

  def create_user_player
    @user_board = Board.new
    @user_board.add_cells

    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)

    @ships << @user_cruiser
    @ships << @user_submarine
  end

  def create_computer_player
    @comp_ships = []
    @computer_board = Board.new
    @computer_board.add_cells

    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)

    @comp_ships << @computer_cruiser
      @ships << @computer_cruiser
    @comp_ships << @computer_submarine
      @ships << @computer_submarine

    @comp_ships.each do |ship| # ships method lives in game file now
      random_coordinates = @computer_board.cells.keys.sample(ship.length)

      until @computer_board.valid_placement?(ship, random_coordinates)
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
      end

      @computer_board.place(ship, random_coordinates)
    end
  end

  def computer_turn
    puts "Firing my missile..."

    comp_coordinate = @user_board.cells.keys.sample(1).join

    until @user_board.valid_coordinate?(comp_coordinate) && !@user_board.cells[comp_coordinate].fired_upon?
      comp_coordinate = @user_board.cells.keys.sample(1).join
    end

    # comp_coordinate

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
