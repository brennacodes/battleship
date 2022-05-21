require './lib2/helper'
require './lib2/messages'

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

  def p1_ships
    ships =  @player.fleet
    ships.map do |ship|
      puts "#{ship.type}: #{ship.length} units"
    end
  end

  def p1_ship_name(which)
    @player.fleet[which].type
  end

  def p1_board
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
    if @input == 'p'
      line_break
      begin_message
      p1_board.render(true)
      setup_game
    else
      abort
    end
  end

  def setup_game
    line_break
    ships_to_be_placed
    p1_ships
    ships_placed = []
    until ships_placed.length == @player.fleet.length do
      line_break
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      ship = @player.fleet.first
      if p1_board.valid_placement?(ship, @input) == true
        p1_board.place(ship, @input)
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
    ships_placed = []
    until ships_placed.length == @computer.fleet.length do
      line_break
      puts "This is your captain speaking"
      place_ship
      @input = gets.chomp
      @input = @input.split(' ')
      ship = @computer.fleet.first
      if computer_board.valid_placement?(ship, @input) == true
        puts "Let's put her in place"
        computer_board.place(ship, @input)
        ships_placed << ship
        puts "time to rotate!"
        @computer.fleet.rotate!
      else
        line_break
        invalid_coordinates
      end
      puts "let's go one more time!"
    end
    puts "hmmm"
    player_turn
  end

  def player_turn
    your_shot
    @input = gets.chomp
    take_shot(@input)
    return invalid_shot if valid_shot? == false
    shot = p1_board.cells[@input]
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
