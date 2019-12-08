require 'minitest/autorun'
require 'minitest/pride'
require './lib/user'
require './lib/board'
# require './lib/game'
class UserTest < MiniTest::Test

    def setup
      @player = User.new
      @computer = User.new(false)
    end

    def test_user_exists
      assert_instance_of User, @player
      assert_instance_of User, @computer
    end

    def test_computer_player_start_method
      assert_equal Ship, @comp_cruiser
      assert_equal Ship, @comp_sub
    end

    def test_computer_player_sample_method_random_moves
      @board_coords = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]

      assert @board_coords.include?(@comp_sample_move)
    end
end
