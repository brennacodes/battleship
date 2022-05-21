require_relative 'helper'
require 'messages'

class Turn
  include Messages

  attr_reader :board, :player

  def initialize(players)
    @players = players
    @input = ''
    @coordinate = ''
  end

  def place_ship
    puts ships_to_place
    @players[0].fleet[0]
    @player[0].fleet.each do |ship|
      puts place_ship
      @input = gets.chomp
      check_placement(@input)
    end
  end

  def check_placement(coordinates)
    return invalid_placement(coordinates) if @players[0].board.valid_placement?(coordinates) == false
    start_turn
  end

  def invalid_placement(coordinates)
    puts invalid_coordinates
    @input = gets.chomp
    check_placement(@input)
  end

  def player_turn
    puts take_shot
    @coordinate = gets.chomp
    take_shot(@coordinate)
    end_turn
  end

  def computer_turn
    shots_available = @player[1].board.cells.keys
    shot = shots_available.sample
    valid_shot?(shot) == true ? shot.fire_upon : computer_turn
    shot.render(true) == "M" ? computer_missed_shot : computer_made_shot
    end_turn
    player_turn
  end

  def current_player
    @player[0].name
  end

  def take_shot(coordinate)
    return invalid_shot if valid_shot? == false
    shot = @player[1].board.cells[coordinate]
    shot.fire_upon
    shot_results(current_player, shot)
  end

  def valid_shot?(coordinate)
    @player[1].board.valid_coordinate?(coordinate)
  end

  def shot_results(player, coordinate)
    player == 'Computer' ? computer_results : shot_result
  end

  def computer_results
    if computer_made_shot if
    return computer_missed_shot if
  end

  def end_turn
    @players.rotate!
  end

  def game_over?
    return game_over if @player.fleet_health == 0
  end
end


# class Turn
#   attr_reader :board, :rules, :player1, :player2, :game
#
#   def initialize(board, rules, player1, player2)
#     @board = board
#     @rules = rules
#     @player1 = player1
#     @player2 = player2
#     @game = Game.new
#     @database = Database.new
#   end
#
#   def human_turn(player)
#     p "#{player.name} please enter position to place an #{player.token}"
#     print '>'
#     input = human_input_validator(player)
#     @board.board[input].sub!('.', player.token)
#   end
#
#   def computer_turn
#     options = %w[a b c d e f g]
#     random = options.shuffle
#     random = options.shuffle until @board.board[random[0]][-1] == '.'
#     @board.board[random[0]].sub!('.', 'O')
#   end
#
#   def human_move(player)
#     @rules.recycle_winners
#     human_turn(player)
#     @board.print_board
#     @rules.recycle_winners
#     if @rules.winner?(player.token)
#       @database.add_game_won(player.name) unless player.name == 'Player One'
#       p "#{player.name} is the Winner!!!"
#       @game.print_main_menu
#       exit
#     end
#   end
#
#   def computer_move
#     computer_turn
#     @board.print_board
#     @rules.recycle_winners
#     if @rules.winner?('O')
#       p 'The almighty computer has won...'
#       @game.print_main_menu
#       exit
#     end
#   end
#
#   def human_input_validator(player)
#     input = gets.chomp.downcase
#     until   %w[a b c d e f g].include?(input) && @board.board[input][-1] == '.'
#       p "#{player.name} please enter a valid position"
#       print '>'
#       input = gets.chomp.downcase
#     end
#     input
#   end
# end
