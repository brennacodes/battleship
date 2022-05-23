require_relative 'helper'
require_relative 'messages'

class Game
  include Messages
  attr_reader :state,
              :player,
              :computer,
              :input

  def initialize
    @state = 'new'
    @player = Player.new('Player 1')
    @computer = Player.new('Computer')
    @input = ''
  end

  def input_validation
    abort "So long until next time!" if @input == 'quit'
  end

  def player_ships
    ships =  @player.fleet
    ships.map do |ship|
      puts "#{ship.type}: #{ship.length} units"
    end
  end

  def player_ship_name(which)
    @player.fleet[which].type
  end

  def player_board
    @player.board
  end

  def computer_ship_name(index)
    @computer.fleet[index].type
  end

  def computer_board
    @computer.board
  end

  def start_game
    line_break
    welcome
    @input = gets.chomp
    input_validation
    line_break
    begin_message
    line_break
    player_board.rendering(true)
    setup_game
  end

  def setup_game
    line_break
    ships_to_be_placed
    player_ships
    ships_placed = []
    until ships_placed.length == @player.fleet.length do
      line_break
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      ship = @player.fleet.first
      if player_board.valid_placement?(ship, @input) == true
        player_board.place(ship, @input)
        ships_placed << ship
        @player.fleet.rotate!
      else
        line_break
        invalid_coordinates
      end
    end
    computer_setup
  end

  def computer_setup
    c_ships_placed = []
    ship = @computer.fleet.first
    until c_ships_placed.length == @computer.fleet.length do
      line_break
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      if computer_board.valid_placement?(ship, @input) == true
        computer_board.place(ship, @input)
        c_ships_placed << ship
        @computer.fleet.rotate!
      else
        line_break
        invalid_coordinates
      end
    end
    player_turn
  end

  def player_turn
    your_shot
    @input = gets.chomp
    take_shot(@input)
    return invalid_shot if valid_shot? == false
    shot = player_board.cells[@input]
    shot.fire_upon
    shot_result
    @player.fleet_health == 0 ? end_game : computer_turn
  end

  def computer_turn
    shots_available = @player.board.cells.keys
    shot = shots_available.sample
    valid_shot?(@player, shot) == true ? shot.fire_upon : computer_turn
    shot.render(true) == "M" ? computer_missed_shot : computer_made_shot
    @computer.fleet_health == 0 ? end_game : player_turn
  end

  def end_game
    puts game_over
    Menu.new.start_game
  end

end

# def computer_setup
#   c_ships = @computer.fleet
#   c_board = @computer.board
#   ships_placed = []
#   until ships_placed.length == @computer.fleet.length do
#     places = computer_board.coordinates
#     num_places = []
#     c_ships.each {|ship| num_places << ship.length}
#     coordinates = []
#     num_places[0].times {coordinates << places.sample}
#     ship = c_ships[0]
#     if computer_board.valid_placement?(ship, [coordinates]) == true
#       computer_board.place(ship, [coordinates])
#       ships_placed << ship
#       coordinates = []
#       c_ships.rotate!
#     else
#       computer_setup
#     end
#   end
#   player_turn
# end
