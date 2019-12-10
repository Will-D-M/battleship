require_relative 'board'
require_relative 'cell'
require_relative 'ship'

class Player
  attr_accessor :computer_player, :computer_board, :user_player, :user_board, :computer_ships, :user_ships

  def initialize
    @computer_board = nil
    @user_board = nil
    @computer_ships = []
    @user_ships = []
  end

  def create_computer_player
    @computer_board = Board.new
    @computer_board.add_cells

    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)

    @computer_ships << @computer_cruiser
    @computer_ships << @computer_submarine

    @computer_ships.each do |ship| # ships method lives in game file now
      random_coordinates = @computer_board.cells.keys.sample(ship.length)

      until @computer_board.valid_placement?(ship, random_coordinates)
        random_coordinates = @computer_board.cells.keys.sample(ship.length)
      end

      @computer_board.place(ship, random_coordinates)
    end
  end

  def create_user_player
    @user_board = Board.new
    @user_board.add_cells

    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)

    @user_ships << @user_cruiser
    @user_ships << @user_submarine

    puts "Your Cruiser is three units long.\n"
    puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"

    puts @user_board.render
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


  end
end
