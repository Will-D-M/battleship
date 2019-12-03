class Ship
  attr_reader :name, :length
  attr_accessor :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def sunk?
    if @health == 0
      @sunk = true
    else
      @sunk
    end
  end

  def hit
    if @health > 0 && @health <= 3
      @health -= 1
    end
  end

end
