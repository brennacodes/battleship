module CellStates
  def missed?
    (@fired == true) && (@ship == nil) ? true : false
  end

  def missed
    (@fired == false) && (@ship == nil) ? true : false
  end

  def miss
    "M"
  end

  def direct_hit?
    (@fired == true) && (@ship != nil) && (@ship.health > 0)
  end

  def direct_hit
    (@fired == false) && (@ship != nil) && (@ship.health > 0)
  end

  def hit
    "H"
  end

  def ship_sunk?
    if (@fired == true) && (@ship != nil) && (@ship.health == 0)
      true
    else
      false
    end
  end

  def sunk
    "X"
  end

  def ship_placed_here?
    @ship != nil ? true : false
  end

  def ship_here
    "S"
  end

  def empty_cell?
    (@ship == nil) && (@fired == false) ? true : false
  end

  def empty_cell
    "."
  end

  def invisible
    "."
  end
end
