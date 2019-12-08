class User
  attr_reader :computer, :player

  def initialize(player = true)
    @player = player
    @computer = computer
    @comp_turns = {}
    @player_turns = {}
  end

  # def computer_player_start
  #   @board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
  #   @comp_cruiser = Ship.new("Cruiser", 3)
  #   @comp_submarine = Ship.new("Submarine", 2)
  #
  #   @comp_cruiser_move = @board_coords.sample(3)
  #   @comp_sub_move = @board_coords.sample(2)
  #   @board.place(@comp_cruiser, @comp_cruiser_move)
  #   @board.place(@comp_submarine, @comp_sub_move)
  # end
  #
  # def computer_player_moves
  #   @board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
  #   @comp_move = @board_coords.sample
  # end
end
