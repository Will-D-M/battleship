require_relative 'board'
require_relative 'ship'

class Player
  attr_accessor :computer_board, :user_board, :computer_ships, :user_ships

  def initialize
    @computer_board = nil
    @user_board = nil
    @computer_ships = []
    @user_ships = []
  end

  def create_computer_board
    @computer_board = Board.new
    @computer_board.add_cells
  end

  def create_computer_ships
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @computer_ships << @computer_cruiser
    @computer_ships << @computer_submarine
  end

  def place_computer_ships
    @computer_ships.each do |ship|
      random_coordinates = @computer_board.cells.keys.sample(ship.length)

      until @computer_board.valid_placement?(ship, random_coordinates)
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
      end

      @computer_board.place(ship, random_coordinates)
    end
  end

  def create_user_board
    @user_board = Board.new
    @user_board.add_cells
  end

  def create_user_ships
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @user_ships << @user_cruiser
    @user_ships << @user_submarine
  end

  def place_user_ships
    @user_ships.each do |ship|
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
  end

  def computer_takes_shot
    computer_shot_coordinate = @user_board.cells.keys.sample

    until @user_board.valid_coordinate?(computer_shot_coordinate) && !@user_board.cells[computer_shot_coordinate].fired_upon?
      computer_shot_coordinate = @user_board.cells.keys.sample
    end
    
    computer_shot_feedback(computer_shot_coordinate)
  end

  def computer_shot_feedback(computer_shot_coordinate)
    @user_board.cells[computer_shot_coordinate].fire_upon

    if @user_board.cells[computer_shot_coordinate].render == "M"
      result = "miss."
    elsif @user_board.cells[computer_shot_coordinate].render == "H"
      result = "hit!"
    elsif @user_board.cells[computer_shot_coordinate].render == "X"
      result = "hit and sunk your #{@user_board.cells[computer_shot_coordinate].ship.name}!"
    end

    puts "\nMy shot on #{computer_shot_coordinate} was a #{result}\n\n"
  end

end
