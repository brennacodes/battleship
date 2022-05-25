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
    @ship = ''
  end
# HOUSEKEEPING ---------------------------------------
  def input_validation
    abort "So long until next time!" if @input == 'quit' || @input == 'QUIT'
  end

  def player_ships
    ships =  @player.fleet
    ships.map do |ship|
      puts "#{ship.type}: #{ship.length} units"
    end
  end

  def player_ship_name
    ship = @player.fleet.find {|boat| boat.placed == false}
    ship.type
  end

  def player_ship_length
    ship = @player.fleet.find {|boat| boat.placed == false}
    ship.length
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

  def ship_check
    @ship.placed
  end

# GAME START ---------------------------------------

  def start_game
    line_break
    welcome
    @input = gets.chomp.upcase
    input_validation
    line_break
    begin_message
    get_ready
  end

# PLAYER SETUP ---------------------------------------

  def get_ready
    line_break
    player_board.rendering(true)
    line_break
    ships_to_be_placed
    player_ships
    line_break
    ships_placed?
  end

  def ships_placed?
    placed = @player.fleet.map {|ship| ship.placed == true}
    placed.all?(true) == true ? computer_ships_placed? : ship_to_place
  end

  def ship_to_place
    @ship = @player.fleet.find {|boat| boat.placed == false}
    place_your_ship
    line_break
    player_setup
  end

  def player_setup
    @input = gets.chomp.upcase
    @input = @input.split(' ')
    input_validation
    line_break
    return ships_placed? if ship_check == true
    validate_placement(@ship, @input)
  end

  def validate_placement(ship, coordinates)
    return ships_placed? if ship_check == true
    if player_board.valid_placement?(ship, coordinates) == true
      place_ship(ship, coordinates)
    else
      invalid_coordinates
      line_break
      player_setup
    end
  end

  def place_ship(ship, coordinates)
    player_board.place(ship, coordinates)
    player_board.rendering(true)
    line_break
    ships_placed?
  end

# COMPUTER SETUP ---------------------------------------

  def computer_ships_placed?
    placed = @computer.fleet.map {|ship| ship.placed == true}
    placed.all?(true) == true ? player_turn : computer_ship_to_place
  end

  def computer_ship_to_place
    @ship = @computer.fleet.find {|boat| boat.placed == false}
    computer_ship_placement(@ship)
  end

  def computer_ship_placement(this_ship)
    spaces = this_ship.length
    a = computer_board.columns.map {|col| col.each_cons(spaces)}
    a = a.map {|arr| arr.map {|sub| sub}}.flatten(1)
    b = computer_board.rows.map {|row| row.each_cons(spaces)}
    b = b.map {|arr| arr.map {|sub| sub}}.flatten(1)
    spots = a.concat(b)
    coordinates = spots.sample
    computer_validate_placement(this_ship, coordinates)
  end

  def computer_validate_placement(ship, coordinates)
    if computer_board.valid_placement?(ship, coordinates) == true
      computer_place_ship(ship, coordinates)
    else
      computer_ship_placement(@ship)
    end
  end

  def computer_place_ship(ship, coordinates)
    computer_board.place(ship, coordinates)
    computer_ships_placed?
  end

# TURNS ---------------------------------------
  def player_turn
    board_header
    player_board.rendering(true)
    computer_header
    computer_board.rendering
    line_break
    player_take_shot
  end

  def player_take_shot
    your_shot
    @input = gets.chomp.upcase
    input_validation
    line_break
    player_make_shot
  end

  def player_make_shot
    computer_board.take_shot(@input)
    analyze_shot
  end

  def analyze_shot
    shot_analysis
    @computer.fleet_health == 0 ? end_game : computer_turn
  end

  def computer_turn
    shots_available = @player.board.shots_available
    shot = shots_available.sample
    player_board.take_shot(shot)
    player_board.cells[shot].missed? ? computer_missed_shot(shot) : computer_made_shot(shot)
    @player.fleet_health == 0 ? end_game : player_turn
  end

  def shot_analysis
    return sunk_shot if computer_board.cells[@input].ship_sunk? == true
    return hit_shot if computer_board.cells[@input].direct_hit? == true
    return missed_shot if computer_board.cells[@input].missed? == true
  end
# END GAME ---------------------------------------
  def end_game
    if @player.fleet_health > @computer.fleet_health
      winner = @player.name
    else
      winner = @computer.name
    end
    line_break
    puts game_over(winner)
    line_break
    go_again
  end

  def go_again

  end
end
