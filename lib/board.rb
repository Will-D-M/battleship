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
    coord_letter_array = coordinates.map do |c|
      c[0]
    end
    letter_range = coord_letter_array[0]..coord_letter_array[-1]
    coord_letter_array == letter_range.to_a
  end

  def numbers_consecutive?(ship, coordinates)
    coord_nums_array = coordinates.map do |c|
      c[1]
    end
    numbers_range = coord_nums_array[0]..coord_nums_array[-1]
    coord_nums_array == numbers_range.to_a
  end

  def cells_empty?(ship, coordinates)
    if coordinates.all? { |c| valid_coordinate?(c) } == false
      return false
    end

    coordinates.all? do |c|
      @cells[c].ship == nil
    end
  end

  def valid_placement?(ship, coordinates)
    if !correct_length?(ship, coordinates) || !cells_empty?(ship, coordinates)
      false

    elsif letters_same?(ship, coordinates) && numbers_consecutive?(ship, coordinates)
      true

    elsif numbers_same?(ship, coordinates) && letters_consecutive?(ship, coordinates)
      true

    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |c|
        @cells[c].ship = ship
      end
      @cells
    end
  end

end
