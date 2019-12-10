require_relative 'cell'

class Board

  attr_accessor :cells

  def initialize
    @cells = {}
  end

  def add_cells
    board_coordinates = []

    ycoords = ("A".."D").to_a
    xcoords = ("1".."4").to_a

    ycoords.each do |y|
      xcoords.each do |x|
        board_coordinates << y + x
      end
    end

    board_coordinates.each do |c|
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
    coordinates.all? { |c| c[0] == coordinates[0][0] }
  end

  def numbers_same?(ship, coordinates)
    coordinates.all? { |c| c[1] == coordinates[1][1] }
  end

  def letters_consecutive?(ship, coordinates)
    coord_letter_array = coordinates.map { |c| c[0] }
    letter_range = coord_letter_array[0]..coord_letter_array[-1]
    coord_letter_array == letter_range.to_a
  end

  def numbers_consecutive?(ship, coordinates)
    coord_nums_array = coordinates.map { |c| c[1] }
    numbers_range = coord_nums_array[0]..coord_nums_array[-1]
    coord_nums_array == numbers_range.to_a
  end

  def cells_empty?(ship, coordinates)
    if coordinates.all? { |c| valid_coordinate?(c) } == false
      return false
    end

    coordinates.all? { |c| @cells[c].ship == nil }
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
      coordinates.each { |c| @cells[c].ship = ship }
      @cells
    end
  end

  def render(show_ship = false)
    "  1 2 3 4 \n" +
    "A #{["A1", "A2", "A3", "A4"].map { |coord| @cells[coord].render(show_ship)}.join(" ")} \n" +
    "B #{["B1", "B2", "B3", "B4"].map { |coord| @cells[coord].render(show_ship)}.join(" ")} \n" +
    "C #{["C1", "C2", "C3", "C4"].map { |coord| @cells[coord].render(show_ship)}.join(" ")} \n" +
    "D #{["D1", "D2", "D3", "D4"].map { |coord| @cells[coord].render(show_ship)}.join(" ")} \n"
  end

end
