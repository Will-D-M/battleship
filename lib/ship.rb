class Ship
  attr_accessor :name, :length, :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
  end

  def sunk?
    @sunk = false
  end

  def hit
    if @health > 0 && @health <= 3
      @health -= 1
    else
      @sunk == true
    end
  end
  
end
