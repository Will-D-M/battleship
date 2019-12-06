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

  def test_it_begins_with_no_cells
    assert_equal Hash.new, @board.cells
    assert_equal true, @board.cells.empty?
  end

  def test_it_adds_cells
    @board.add_cells
    assert_equal 16, @board.cells.size
  end

  def test_it_verifies_valid_coordinates
    @board.add_cells
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_it_verifies_ship_length_equal_number_of_coordinates
    assert_equal false, @board.correct_length?(@cruiser, ["A1", "A2"])
    assert_equal true, @board.correct_length?(@cruiser, ["B1", "C1", "D1"])
    assert_equal true, @board.correct_length?(@submarine, ["A1", "A2"])
    assert_equal false, @board.correct_length?(@submarine, ["B2", "B3", "B4"])
  end

  def test_letters_are_the_same
    assert_equal true, @board.letters_same?(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.letters_same?(@submarine, ["A1", "B1"])
  end

  def test_numbers_are_the_same
    assert_equal true, @board.numbers_same?(@submarine, ["A1", "B1"])
    assert_equal false, @board.numbers_same?(@cruiser, ["A1", "A2", "A3"])
  end

  def test_letters_are_consecutive
    assert_equal true, @board.letters_consecutive?(@cruiser, ["A1", "B1", "C1"])
    assert_equal false, @board.letters_consecutive?(@submarine, ["D3", "D4"])
    assert_equal false, @board.letters_consecutive?(@submarine, ["A1", "C1"])
  end

  def test_numbers_are_consecutive
    assert_equal true, @board.numbers_consecutive?(@submarine, ["A1", "A2"])
    assert_equal false, @board.numbers_consecutive?(@cruiser, ["A1", "A3", "A4"])
  end

  def test_is_cells_empty
    @board.add_cells

    assert_equal true, @board.cells_empty?(@submarine, ["A1", "B1"])

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.cells_empty?(@submarine, ["A1", "B1"])
  end

  def test_valid_placement
    @board.add_cells

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A3", "A4"])

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])

    assert_equal false, @board.valid_placement?(@cruiser,["C3", "D3", "E3"])
    assert_equal false, @board.valid_placement?(@submarine,["D1", "E1"])

    assert_equal false, @board.valid_placement?(@cruiser, ["B1", "A1", "C1"])

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["B1", "D1"])

    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["B2", "B1"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "A1"])

    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_overlapping_ships_returns_false
    @board.add_cells

    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal true, @board.valid_placement?(@submarine, ["B1", "B2"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_it_renders_board
    skip
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal String, board.render.class
  end
end
