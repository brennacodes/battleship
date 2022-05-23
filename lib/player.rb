class Player
  attr_reader :name,
              :fleet,
              :fleet_health,
              :board

  def initialize(name)
    @name = name
    @fleet = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @fleet_health = fleet_health
    @board = Board.new(10)
  end

  def fleet_health
    @fleet.empty? ? "No ships here..." : @fleet_health = @fleet.sum {|ship| ship.health}
  end

  # def make_ship(type, length)
  #   @fleet << Ship.new(type, length)
  # end
end
