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
    abort "So long until next time!" if @input == 'quit' || @input == 'QUIT'
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
    @input = gets.chomp.upcase
    input_validation
    line_break
    begin_message
    line_break
    player_board.rendering(true)
    line_break
    get_ready
  end

  def get_ready
    ships_to_be_placed
    player_ships
    line_break
    player_setup
  end

  def player_setup
    (@player.fleet.length).times do
      ship = @player.fleet.first
      place_ship
      line_break
      @input = gets.chomp.upcase
      @input = @input.split(' ')
      input_validation
      line_break
      if ship.placed == false
        if player_board.valid_placement?(ship, @input) == true
          player_board.place(ship, @input)
          @player.fleet.rotate!
          player_board.rendering(true)
          line_break
        else
          input_validation
          invalid_coordinates
          line_break
          player_setup
        end
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
    player_turn
  end

  def player_turn
    board_header
    player_board.rendering(true)
    computer_header
    computer_board.rendering
    line_break
    your_shot
    @input = gets.chomp.upcase
    input_validation
    line_break
    computer_board.take_shot(@input)
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
    return missed_shot if computer_board.cells[@input].missed? == true
    return hit_shot if computer_board.cells[@input].direct_hit? == true
  end

  def end_game
    if @player.fleet_health > @computer.fleet_health
      winner = @player.name
    else
      winner = @computer.name
    end
    line_break
    puts game_over(winner)
    line_break
    Menu.new.start_game
  end
end
