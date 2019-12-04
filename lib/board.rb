require_relative 'cell'

class Board

  attr_accessor :cells, :board_cells

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

end
