class Ship
  attr_reader :name, :length
  attr_accessor :health, :placed

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @placed = false
  end

  def health
    @health
  end

  def sunk?
    @health == 0
  end

  def hit
    @health -= 1
  end

  def placed?
    @placed
  end
end
