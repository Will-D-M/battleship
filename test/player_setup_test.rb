require 'minitest/autorun'
require 'minitest/pride'
require './lib/player_setup'
require './lib/ship'

class PlayerSetupTest < Minitest::Test

  def setup
    @computer = PlayerSetup.new
    @user = PlayerSetup.new
  end

  def test_it_exists
    assert_instance_of PlayerSetup, @computer
    assert_instance_of PlayerSetup, @user
  end

  def test_it_has_attributes
    assert_nil @computer_board
    assert_nil @user_board
    assert_equal [], @user.computer_ships
    assert_equal [], @user.user_ships
  end

  def test_it_can_create_computer_boards
    @computer.create_computer_board
    assert_instance_of Board, @computer.computer_board
    refute @computer.computer_board.cells.empty?
  end

  def test_it_can_create_computer_ships
    @computer.create_computer_ships

    assert_instance_of Ship, @computer.computer_ships[0]
    assert_instance_of Ship, @computer.computer_ships[-1]
  end

  def test_it_can_create_user_boards
    @user.create_user_board
    assert_instance_of Board, @user.user_board
    refute @user.user_board.cells.empty?
  end

  def test_it_can_create_user_ships
    @user.create_user_ships

    assert_instance_of Ship, @user.user_ships[0]
    assert_instance_of Ship, @user.user_ships[-1]
  end

  def test_it_can_place_computer_ships
    @computer.create_computer_board
    @computer.create_computer_ships
    @computer.place_computer_ships

    assert_instance_of Array, @computer.computer_ships
    refute @computer.computer_ships.empty?
    assert_equal 2, @computer.computer_ships.size
  end

  def test_it_can_place_user_ships
    @user.create_user_board
    @user.create_user_ships

    @user.place_user_ships(Ship.new("Cruiser", 3), ["A1", "A2", "A3"])
    @user.place_user_ships(Ship.new("Submarine", 2), ["B1", "B2"])

    refute @user.user_ships.empty?
    assert_instance_of Array, @user.user_ships
    assert_equal 2, @user.user_ships.size
  end

end
