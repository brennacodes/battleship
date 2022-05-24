module CellStates
  def missed?
    (@fired == true) && (@ship == nil) ? true : false
  end

  def missed
    (@fired == false) && (@ship == nil) ? true : false
  end

  def miss
    '🐳'
  end

  def direct_hit?
    (@fired == true) && (@ship != nil) && (@ship.health > 0)
  end

  def direct_hit
    (@fired == false) && (@ship != nil) && (@ship.health > 0)
  end

  def hit
    "💥"
  end

  def ship_sunk?
    if (@fired == true) && (@ship != nil) && (@ship.health == 0)
      true
    else
      false
    end
  end

  def sunk
    "💀"
  end

  def ship_placed_here?
    @ship != nil ? true : false
  end

  def ship_here
    "🚢"
  end

  def empty_cell?
    (@ship == nil) && (@fired == false) ? true : false
  end

  def empty_cell
    "🌊"
  end

  def invisible
    "🌊"
  end

  def hashy
    num = ['⓵', '⓶', '⓷', '⓸', '⓹', '⓺', '⓻', '⓼', '⓽', '⓾']
    lets =  ['🅰', '🅱', '🅲', '🅳', '🅴', '🅵', '🅶', '🅷', '🅸', '🅹']
    new = num.zip(lets)
    new = new.to_h
  end
end
