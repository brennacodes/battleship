require_relative 'helper'
require_relative 'messages'
require_relative 'cell_states'

class Cell
  include Messages
  include CellStates

  attr_reader :coordinate,
              :fired,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired = false
  end

  def ship
    @ship
  end

  def empty?
    @ship == nil ? true : false
  end

  def place_ship(type)
    @ship = type
    @ship.placed = true
  end

  def fired_upon?
    @fired
  end

  def fire_upon
    if direct_hit
      @ship.health -= 1
      @fired = true
    else missed == true
      @fired = true
    end
  end

  def render(visibility = false)
    visibility ? make_visible : invisible_ships
  end

  def make_visible
    return miss if missed? == true
    return hit if direct_hit? == true
    return sunk if ship_sunk? == true
    return ship_here if ship_placed_here? == true
    return empty_cell if empty_cell? == true
  end

  def invisible_ships
    return miss if missed? == true
    return hit if direct_hit? == true
    return sunk if ship_sunk? == true
    return invisible if ship_placed_here? == true
    return empty_cell if empty_cell? == true
  end
end
