require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/board'
require_relative '../lib/game'

class GameTest < MiniTest::Test

    def test_user_shown_welcome_and_main_menu
      assert_equal true, game.welcome
      assert_equal true, game.main_menu
    end

    def test_user_can_enter_valid_sequences_to_place_both_ships
      assert_equal @cells, @user_board.place(@user_cruiser, user_coordinates).call
      assert_equal @cells, @user_board.place(@user_submarine, user_coordinates).call
    end

    def test_user_cannot_enter_invalid_coordinates

    end

    def test_user_board_displays_accurate_data

    end

    def test_computer_board_displays_accurate_data

    end

    def test_user_can_choose_valid_coordinate

    end

    def test_user_shots_report

    end

    def test_computer_shots_report

    end

    def test_user_prompt_repeated_shots

    end

    def test_board_updates_turns

    end

    def test_game_ends_when_all_user_ships_sunk

    end

    def test_game_ends_when_all_computer_ships_sunk

    end

    def test_game_reports_winner

    end

    def test_game_reverts_back_to_main_menu_after_game_over

    end
end
