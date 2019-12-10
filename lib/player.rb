class Player
  attr_reader :computer_player, :computer_board, :user_player, :user_board

  def initialize # Not sure these should be nil values... they should just equal each other.
    @computer_player = nil
    @computer_board = nil
    @user_player = nil
    @user_board = nil
  end

  def create_user_player
    @user_player = Player.new
# May have to create Player instance in Game file? Not sure how to call. Ditto for Computer instance

    @user_board = Board.new
    @user_board.add_cells

    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)

    @user_player.add_ships(@user_cruiser)
    @user_player.add_ships(@user_submarine)
  end

  def create_computer_player
    @computer_player = Player.new

    @computer_board = Board.new
    @computer_board.add_cells

    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)

    @computer_player.add_ships(@computer_cruiser)
    @computer_player.add_ships(@computer_submarine)

    @computer_player.ships.each do |ship| # ships method lives in game file now
      random_coordinates = @computer_board.cells.keys.sample(ship.length)

      until @computer_board.valid_placement?(ship, random_coordinates)
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
      end

      @computer_board.place(ship, random_coordinates)
    end
  end

  def computer_turn
    puts "Computer is firing missile..."
    comp_coordinate = @user_board.cells.keys.sample(1).join

    until @user_board.valid_coordinate?(comp_coordinate) && !@user_board.cells[comp_coordinate].fired_upon?
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

    puts "\nComputer shot on #{comp_coordinate} was a #{result}\n\n"

    if @user_player.ships.all? { |ship| ship.sunk? }
      puts "Computer wins!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      @game.user_turn # This may be an issue!!! check accuracy of return
    end
  end
end
