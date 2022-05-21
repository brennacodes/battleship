module CellStates
  def miss
    "M"
  end

  def hit
    "X"
  end

  def ship_here
    "S"
  end

  def sunk
    "X"
  end

  def empty_cell
    "."
  end

  def missed?
    @fired == true && @ship == nil
  end

  def direct_hit?
    @fired == true && @ship != nil && @ship.health != 0
  end

  def sinker?
    @fired == true && @ship != nil && @ship.health == 0
  end

  # def empty_state?
  #   @fired == false && @ship == nil
  # end

  # def ship_here?
  #   show == true && @ship != nil
  # end
end
