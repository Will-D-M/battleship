class Player

  attr_reader :ships

  def initialize
    @ships = []
  end

  def add_ships(ship)
    @ships << ship
  end

end
