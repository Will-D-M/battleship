require_relative 'cell'

class Board

  attr_accessor :cells

  def initialize
    @cells = {}
  end

  def add_cells
    board_coords = []

    yrange = "A".."D"
    xrange = "1".."4"
    ycoords = yrange.to_a
    xcoords = xrange.to_a

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

  def letters_same?(ship, coordinates)
    coordinates.all? do |c|
      c[0] == coordinates[0][0]
    end
  end

  def numbers_same?(ship, coordinates)
  end

  def letters_consecutive?(ship, coordinates)
  end

  def numbers_consecutive?(ship, coordinates)
  end

  # def cells_empty?(ship, coordinates)
  # end

  def valid_placement(ship, coordinates)
    return true if valid_coordinate? && letters_same? && numbers_consecutive?
    return true if valid_coordinate? && numbers_same? && letters_consecutive?
    return false
  end

end
