require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/game'
class GameTest < MiniTest::Test

    def setup
      @game = Game.new
    end

    def test_game_starts_main_menu_displays
      assert_instance_of Game, @game
      require 'pry'; binding.pry
    end

    def test_computer_can_place_ships_in_random_valid_locations
      skip

    end

    def test_computer_board_displays_accurate_data
      skip

    end

    def test_computer_chooses_a_random_shot
      skip

    end


    def test_computer_does_not_fire_on_same_coordinate_twice
      skip

    end

    def test_computer_shots_report
      skip

    end

    def test_user_can_enter_valid_sequences_to_place_both_ships
      skip

    end

    def test_user_cannot_enter_invalid_coordinates
      skip

    end

    def test_user_board_displays_accurate_data
      skip

    end

    def test_user_can_choose_valid_coordinate
      skip

    end

    def test_user_shots_report
      skip

    end

    def test_user_prompt_repeated_shots
      skip

    end

    def test_board_updates_turns
      skip

    end

    def test_game_ends_when_all_user_ships_sunk
      skip

    end

    def test_game_ends_when_all_computer_ships_sunk
      skip

    end

    def test_game_reports_winner
      skip

    end

    def test_game_reverts_back_to_main_menu_after_game_over
      skip

    end
end
