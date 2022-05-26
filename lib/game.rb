require_relative 'helper'
require './lib/cell_states'

class Game
  include Messages
  include CellStates

  attr_reader :player,
              :computer,
              :input

  def initialize
    @player = Player.new('Player 1')
    @computer = Player.new('Computer')
    @input = ''
    @ship = ''
  end

  def start_game
    line_break
    welcome
    @input = gets.chomp.upcase
    input_validation
    line_break
    custom_board_question
  end

  def custom_board_question
    custom_board_size?
    answer = gets.chomp
    answer == 'y' ? get_board_width : make_boards(width, height)
  end

  def get_board_width
    enter_board_width
    width = gets.chomp.to_i
    width <= 10 ? get_board_height(width) : get_board_width
  end

  def get_board_height(width)
    enter_board_height
    height = gets.chomp.to_i
    height <= 10 ? make_boards(width, height) : get_board_height
  end

  def make_boards(width = 4, height = 4)
    @player.make_board(width, height)
    @computer.make_board(width, height)
    ship_question
  end

  def ship_question
    line_break
    make_own_ships?
    answer = gets.chomp
    answer == 'y' ? custom_ships : make_ships
  end

  def custom_ships
    enter_ship_name
    name = gets.chomp
    enter_ship_length
    length = gets.chomp.to_i
    @player.make_ship(name, length)
    @computer.make_ship(name, length)
    make_another_ship?
    answer = gets.chomp
    answer == 'y' ? custom_ships : get_ready
  end

  def make_ships
    @player.make_ship('Cruiser', 3)
    @player.make_ship('Submarine', 2)
    @computer.make_ship('Cruiser', 3)
    @computer.make_ship('Submarine', 2)
    get_ready
  end

  def input_validation
    if @input == 'quit' || @input == 'QUIT'
      buhbye
      abort
    end
  end

  def player_ships
    ships =  @player.fleet
    ships.map do |ship|
      puts "⬜️ #{ship.name}: #{ship.length} units"
    end
  end

  def player_ship_name
    ship = @player.fleet.find {|boat| boat.placed == false}
    ship.name
  end

  def player_ship_length
    ship = @player.fleet.find {|boat| boat.placed == false}
    ship.length
  end

  def player_board
    @player.board
  end

  def computer_ship_name(index)
    @computer.fleet[index].name
  end

  def computer_board
    @computer.board
  end

  def ship_placed?
    @ship.placed
  end

  def get_ready
    line_break
    begin_message
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
    enter_ship_coordinates
  end

  def enter_ship_coordinates
    @input = gets.chomp.upcase
    @input = @input.split(' ')
    input_validation
    line_break
    return ships_placed? if ship_placed? == true
    validate_placement(@ship, @input)
  end

  def validate_placement(ship, coordinates)
    return ships_placed? if ship_placed? == true
    if player_board.valid_placement?(@ship, @input) == true
      place_ship(ship, coordinates)
    else
      invalid_coordinates
      line_break
      enter_ship_coordinates
    end
  end

  def place_ship(ship, coordinates)
    player_board.place(ship, coordinates)
    player_board.rendering(true)
    line_break
    ships_placed?
  end

  def computer_ships_placed?
    placed = @computer.fleet.map {|ship| ship.placed == true}
    placed.all?(true) == true ? games_begin : computer_ship_to_place
  end

  def computer_ship_to_place
    @ship = @computer.fleet.find {|boat| boat.placed == false}
    computer_ship_placement(@ship)
  end

  def computer_ship_placement(this_ship)
    spaces = this_ship.length.to_i
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

  def games_begin
    line_break
    let_games_begin
    line_break
    board_header
    player_board.rendering(true)
    computer_header
    computer_board.rendering
    line_break
    player_turn
  end

  def player_turn
    your_shot
    @input = gets.chomp.upcase
    input_validation
    line_break
    check_if_valid_coordinate
  end

  def check_if_valid_coordinate
    if computer_board.valid_coordinate?(@input) == true
      check_if_valid_shot
    else
      invalid_coordinate
      player_take_shot
    end
  end

  def check_if_valid_shot
    if computer_board.valid_shot?(@input) == true
      check_if_already_fired
    else
      invalid_shot
      player_take_shot
    end
  end

  def check_if_already_fired
    if computer_board.cells[@input].fired_upon? == false
      computer_board.take_shot(@input)
      end_player_turn
    else
      already_shot_here
      player_take_shot
    end
  end

  def end_player_turn
    shot_analysis
    board_header
    player_board.rendering(true)
    @computer.fleet_health == 0 ? end_game : computer_turn
  end

  def shot_analysis
    if computer_board.cells[@input].missed? == true
      missed_shot
    elsif computer_board.cells[@input].direct_hit? == true
      hit_shot
    else computer_board.cells[@input].ship_sunk? == true
      sunk_shot
    end
  end

  def computer_turn
    shots_available = @player.board.shots_available
    shot = shots_available.sample
    player_board.take_shot(shot)
    computer_end_turn(shot)
  end

  def computer_end_turn(shot)
    if player_board.cells[shot].missed?
      computer_missed_shot(shot)
    else
      computer_made_shot(shot)
    end
    computer_header
    computer_board.rendering
    line_break
    @player.fleet_health == 0 ? end_game : player_turn
  end

  def end_game
    if @player.fleet_health > @computer.fleet_health
      winner = @player.name
    else
      winner = @computer.name
    end
    line_break
    game_over(winner)
    line_break
    go_again
  end

  def go_again
    exec 'ruby lib/menu.rb'
  end
end
