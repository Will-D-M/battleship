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
    return "M" if empty? && fired_upon?
    return "." if empty?
    return "S" if !empty? && !fired_upon? && show_ship == true
    return "." if !empty? && !fired_upon?
    return "X" if !empty? && fired_upon? && @ship.sunk?
    return "H" if !empty? && fired_upon?
  end

end
