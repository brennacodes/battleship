require 'helper.rb'
require 'messages.rb'

class Game
  include Messages

  attr_reader :input, :players, :board

  def initialize
    @input = ''
    @players = []
    @boards = []
  end

  def start
    @input = gets.chomp
    return add_players if @input == 'p'
    quit_check
  end

  def quit_check
    abort if @input == 'q'
  end

  def add_players
    puts add_player
    puts line_break
    @input = gets.chomp
    name = @input
    @players << Player.new(name)
    @players << Player.new('Computer')
    # puts verify_name
  end

  def get_boards
    @boards << @players.each {|player| player.board}
  end

  def begin_game
    puts begin_message
    puts @players[0].board.render(true)
    place_ships
  end

  def end_turn
    @players.rotate!
  end
end
