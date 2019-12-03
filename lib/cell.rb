class Cell
  attr_reader :coordinate
  attr_accessor :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true

    if !empty?
      @ship.health -= 1
    end
  end

  def render(show_ship = false)
    return "." if @fired_upon == false && empty?
    return "M" if @fired_upon == true && empty?
    return "S" if show_ship == true && !empty?
    return "X" if @ship.sunk? == true
    return "H" if !empty? && @fired_upon == true
  end

end
