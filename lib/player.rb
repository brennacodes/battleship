require 'helper'

class Player
  attr_reader :name,
              :fleet,
              :fleet_health,
              :board

  def initialize(name)
    @name = name
    @fleet = []
    @fleet_health = fleet_health
    @board = Board.new
  end

  def make_ship(type, length)
    @fleet << Ship.new(type, length)
  end

  def fleet_health
    @fleet.empty? ? return : @fleet_health = @fleet.sum {|ship| ship.health}
  end
end

# class Player
#   attr_reader :name, :token
#
#   def initialize(name, token)
#     @name = name
#     @token = token
#     @database = Database.new
#   end
#
#   def change_name(name)
#     @name = name.capitalize
#     @database.add_user(name.capitalize)
#     @database.add_game_played(name.capitalize)
#   end
#
#   def enter_names(player1, player2)
#     p "Please enter player1's name"
#     print '>'
#     player1.change_name(gets.chomp)
#     p "Please enter player2's name"
#     print '>'
#     player2.change_name(gets.chomp)
#   end
# end
