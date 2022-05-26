class Player
  attr_reader :name,
              :fleet,
              :fleet_health,
              :board

  def initialize(name)
    @name = name
    @fleet = []
    @fleet_health = fleet_health
    @board = ''
  end

  def fleet_health
    @fleet.empty? ? "You're a captain with no ships." : @fleet_health = @fleet.sum {|ship| ship.health}
  end

  def make_ship(name, length)
    @fleet.push(Ship.new(name, length))
  end

  def make_board(width, height)
    @board = Board.new(width, height)
  end
end
