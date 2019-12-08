require_relative 'ship'
require_relative 'board'

class User
  attr_reader :computer, :player

  def initialize(player = true)
    @player = player
    @computer = computer
    @comp_turns = {}
    @player_turns = {}
  end

  def computer_player_start
    @board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @comp_cruiser = Ship.new("Cruiser", 3)
    @comp_sub = Ship.new("Submarine", 2)

    @comp_cruiser_placer = @board_coords.sample(3)
    @comp_sub_placer = @board_coords.sample(2)
    @board.place(@comp_cruiser, @comp_cruiser_placer)
    @board.place(@comp_sub, @comp_sub_placer)
  end

  def computer_player_moves_and_turns
    @board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @comp_move = @board_coords.sample
    @board_coords.delete(@comp_move)
    @comp_turns[@comp_move] = @board.cells.valid_placement?
  end

  def human_player_start(player_cruiser_placer, player_sub_placer)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)

    @board.place(@player_cruiser, player_cruiser_placer)
    @board.place(@player_sub, player_sub_placer)
  end

  def human_player_turns(player_move)
    @board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    @player_turns[@player_moves] = @board.cells
    @board_coords.delete(@player_move)
    @player_turns[@player_move] = @board.cells.valid_placement?
  end
end
