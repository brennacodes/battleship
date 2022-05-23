require_relative 'helper'

class Game
  include Messages
  include CellStates

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
    line_break
    setup_game
  end

  def setup_game
    ships_to_be_placed
    player_ships
    ships_placed = []
    (@player.fleet.length).times do
      line_break
      place_ship
      line_break
      @input = gets.chomp
      line_break
      input_validation
      @input = @input.split(' ')
      ship = @player.fleet.first
      if player_board.valid_placement?(ship, @input) == true
        player_board.place(ship, @input)
        ships_placed.push(ship)
        @player.fleet.rotate!
        player_board.rendering(true)
      else
        line_break
        invalid_coordinates
      end
    end
    computer_setup
  end

  def computer_setup
    spots = computer_board.rows + computer_board.columns
    new_places = spots.map {|place| place.reverse}
    spots = (spots + new_places).sort
    fleet = @computer.fleet
    fleet.map do |ship|
      places = []
      spaces = ship.length
      enum = spots.map {|place| place.each_cons(spaces)}
      enum.each do |arr|
        arr.map do |e|
          places.push(e)
        end
      end
      placement = places.sample
      until computer_board.valid_placement?(ship, placement) == true do
        placement = places.sample
      end
      computer_board.place(ship, placement)
    end
    setup_game
  end

  def player_turn
    board_header
    player_board.rendering(true)
    line_break
    your_shot
    @input = gets.chomp
    computer_board.take_shot(@input)
    shot_analysis
    @computer.fleet_health == 0 ? end_game : computer_turn
  end

  def computer_turn
    shots_available = @player.board.shots_available
    shot = shots_available.sample
    player_board.take_shot(shot)
    require "pry"; binding.pry
    shot.render(true) == miss ? computer_missed_shot : computer_made_shot
    @player.fleet_health == 0 ? end_game : computer_turn
  end

  def shot_analysis
    return sunk_shot if computer_board.cells[@input].ship_sunk? == true
    return missed_shot if computer_board.cells[@input].missed? == true
    return hit_shot if computer_board.cells[@input].direct_hit? == true
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
