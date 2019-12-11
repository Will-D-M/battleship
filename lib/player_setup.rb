require_relative 'board'
require_relative 'ship'

class PlayerSetup
  attr_reader :computer_board, :user_board, :computer_ships, :user_ships

  def initialize
    @computer_board = nil
    @computer_ships = []
    @user_board = nil
    @user_ships = []
  end

  def create_computer_board
    @computer_board = Board.new
    @computer_board.add_cells
  end

  def create_computer_ships
    computer_cruiser = Ship.new("Cruiser", 3)
    computer_submarine = Ship.new("Submarine", 2)
    @computer_ships << computer_cruiser
    @computer_ships << computer_submarine
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
    user_cruiser = Ship.new("Cruiser", 3)
    user_submarine = Ship.new("Submarine", 2)
    @user_ships << user_cruiser
    @user_ships << user_submarine
  end

  def place_user_ships(ship, user_coordinates)
      @user_board.place(ship, user_coordinates)
  end

end
