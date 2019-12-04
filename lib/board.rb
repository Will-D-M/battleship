class Board
  attr_reader :cells

  def initialize
    @cells = {}
    @board_cells = {}
  end

  def cells
    board_coords = []
    yrange = "A".."D"
    xrange = "1".."4"
    binding.pry; require 'pry'
    ycoords = yrange.to_a
    xcoords = xrange.to_a
    coords_merge = ycoords.zip(xcoords)

    coords_merge.each {|m| board_coords << m.join } # creates accurate array of coords
    board_coords.each {|c| @board_cells[c] = Cell.new(c) }

    p @board_cells
  end

end
