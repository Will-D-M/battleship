require_relative 'cell'
require_relative 'ship'

class Board

  attr_accessor :cells

  def initialize
    @cells = {}
  end

  def add_cells
    board_coords = []

    # board_size = gets.chomp if board_size % 2 = 0
    # yrange = ("A"..Math.sqrt(board_size)).to_a
    # yrange = ("1"..(Math.sqrt(board_size).to_i.to_s)).to_a

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
    return true if correct_length?(ship, coordinates) && numbers_consecutive?(ship, coordinates) && letters_consecutive?(ship, coordinates)
    # return true if correct_length?(ship, coordinates)
    return false
  end

  # Board Render Method Psuedo

  # def render(default_to_false)
      # method_repo_array = []
    # if render(false)
        # method_repo_array << " " + ("1".."4").to_a.join(" ") + " /n"
        # method_repo_array << " " + ("1".."4").to_a.join(" ") + " /n"
end
