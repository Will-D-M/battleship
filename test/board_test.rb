require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_has_attributes
    empty_test_hash = {}
    assert_instance_of Hash, @board.cells
    assert_equal empty_test_hash, @board.cells
  end

  def test_it_adds_cells
    @board.add_cells
    assert_instance_of Hash, @board.cells
    assert_instance_of String, @board.cells.keys.first
    assert_instance_of Cell, @board.cells.values.first
    assert_equal 16, @board.cells.size
  end

  def test_it_verifies_valid_coordinates
    @board.add_cells
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("!")
  end

  def test_it_verifies_ship_length_equal_number_of_coordinates
    refute @board.correct_length?(@cruiser, ["A1"])
    assert @board.correct_length?(@cruiser, ["B1", "C1", "D1"])
    refute @board.correct_length?(@submarine, ["B2", "B3", "B4"])
    assert @board.correct_length?(@submarine, ["A1", "A2"])
  end

  def test_letters_are_the_same
    assert @board.letters_same?(@cruiser, ["A1", "A2", "A3"])
    refute @board.letters_same?(@submarine, ["A1", "B1"])
  end

  def test_numbers_are_the_same
    assert @board.numbers_same?(@submarine, ["A1", "B1"])
    refute @board.numbers_same?(@cruiser, ["A1", "A2", "A3"])
  end

  def test_letters_are_consecutive
    assert @board.letters_consecutive?(@cruiser, ["A1", "B1", "C1"])
    refute @board.letters_consecutive?(@submarine, ["D3", "D4"])
    refute @board.letters_consecutive?(@submarine, ["A1", "C1"])
  end

  def test_numbers_are_consecutive
    assert @board.numbers_consecutive?(@submarine, ["A1", "A2"])
    refute @board.numbers_consecutive?(@cruiser, ["A1", "A3", "A4"])
    refute @board.numbers_consecutive?(@cruiser, ["A1", "A3", "A5"])
  end

  def test_is_cells_empty
    @board.add_cells

    assert @board.cells_empty?(@submarine, ["A1", "B1"])
  end

  def test_valid_placement
    @board.add_cells

    refute @board.valid_placement?(@cruiser, ["A1", "A2"])
    refute @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    refute @board.valid_placement?(@cruiser, ["A1"])
    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A3", "A4"])

    refute @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    refute @board.valid_placement?(@submarine, ["C2", "D3"])

    refute @board.valid_placement?(@cruiser,["C3", "D3", "E3"])
    refute @board.valid_placement?(@submarine,["D4", "D5"])

    refute @board.valid_placement?(@cruiser, ["B1", "A1", "C1"])

    refute @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    refute @board.valid_placement?(@submarine, ["B1", "D1"])

    refute @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    refute @board.valid_placement?(@submarine, ["B2", "B1"])

    refute @board.valid_placement?(@submarine, ["A1", "A1"])

    assert @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert @board.valid_placement?(@submarine, ["A1", "A2"])
    assert @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_overlapping_ships_returns_false
    @board.add_cells

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert @board.valid_placement?(@submarine, ["B1", "B2"])
    refute @board.valid_placement?(@submarine, ["A1", "B1"])
    refute @board.valid_placement?(@submarine, ["B4", "B5"])
  end

  def test_it_can_render_when_ships_are_hidden
    @board.add_cells

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render

    @board.place(@submarine, ["D3", "D4"])

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render
  end

  def test_it_can_render_showing_ships
    @board.add_cells

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", @board.render(true)

    @board.place(@submarine, ["D3", "D4"])

    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . S S \n", @board.render(true)
  end

end
