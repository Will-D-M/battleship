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
    letter_array = letter_range.to_a
    coord_letter_array == letter_array
  end

  def numbers_consecutive?(ship, coordinates)
    coord_nums_array = coordinates.map do |c|
      c[1]
    end
    numbers_range = coord_nums_array[0]..coord_nums_array[-1]
    numbers_array = numbers_range.to_a

    if coord_nums_array == numbers_array
      true
    elsif coord_nums_array[0] > coord_nums_array[-1]
      if coord_nums_array == numbers_array.reverse!
        true
      else
        false
      end
    end
  end

  def valid_placement?(ship, coordinates)
    if !correct_length?(ship, coordinates)
      false
    elsif letters_same?(ship, coordinates)
      false
    elsif numbers_same?(ship, coordinates)
      false
    elsif letters_consecutive?(ship, coordinates)
      false
    elsif numbers_consecutive?(ship, coordinates)
      false
    elsif coordinates
      require 'pry'; binding.pry
      coordinates.each do |c|
        if valid_coordinate?(c) == true
          true
        else
          false
        end
      end
    else
      false
    end
  end

  def render(hidden = false)
    render_array = []
    hidden == true && no_plays
      render_array << " " + ("1".."4").to_a.join(" ") + " /n"
      render_array << "A " self.cell.render
      render_array << "/n"
      render_array <<
      render_array << "B "
      "/n"
      render_array << "C "
      "/n"
      render_array << "D "
      "/n"

      if @fired_upon == false && empty?
        render_array << "."
      elsif @fired_upon == true && empty?
        render_array << "M"
      elsif @ship.sunk? == true
        render_array << "X"
      elsif !empty? && @fired_upon == true
        render_array << "H"
      elsif show_ship == true && !empty?
        "S"
      end
      end


      render_array << " " + "B "


    render_array.join
end
