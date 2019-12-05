require_relative 'cell'

class Board

  attr_accessor :cells

  def initialize
    @cells = {}
  end

  def add_cells
    board_coords = []

    ycoords = ("A".."D").to_a
    xcoords = ("1".."4").to_a

    ycoords.each do |y|
      xcoords.each do |x|
        board_coords << y + x
      end
    end

    board_coords.each do |c|
      @cells[c] = Cell.new(c)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def correct_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def letters_same?(ship, coordinates)
    coordinates.all? do |c|
      c[0] == coordinates[0][0]
    end
  end

  def numbers_same?(ship, coordinates)
    coordinates.all? do |c|
      c[1] == coordinates[1][1]
    end
  end

  def letters_consecutive?(ship, coordinates)
    x = coordinates.map do |c|
      c[0]
    end
    letter_range = x[0]..x[-1]
    tester = letter_range.to_a
    x == tester
  end

  def numbers_consecutive?(ship, coordinates)
    x = coordinates.map do |c|
      c[1]
    end
    letter_range = x[0]..x[-1]
    tester = letter_range.to_a
    x == tester
  end

  def valid_placement(ship, coordinates)
    return true if correct_length? && valid_coordinate? && letters_same? && numbers_consecutive?
    return true if correct_length? && valid_coordinate? && numbers_same? && letters_consecutive?
    return false
  end
end
