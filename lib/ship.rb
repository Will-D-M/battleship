class Ship
  attr_accessor :name, :length, :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
    @sunk = false
  end

  def sunk?
    @sunk
  end

  def hit
    if @health > 0 && @health <= 3
      @health -= 1
    end
      @sunk = true
  end

end
