module Messages
  def welcome
    puts "🟩 Welcome to BATTLESHIP\n🟩 Type 'play' to play. Type 'quit' to quit at any time."
  end

  def make_own_ships?
    puts "Would you like to make your own ships?\nPress 'y' for yes, or 'n' for no."
  end

  def begin_message
    puts "⬛️ I have laid out my ships on my ✨super secret✨ board.\n⬛️ Now you need to lay out your two ships.\n⬛️ I am a computer, so I can 'technically' see your ships,\n⬛️ but I'm not actually 'looking'...👀\n⬛️ Promise."
  end

  def enter_ship_name
    puts "⬛️ Enter the name of your ship below:\n"
  end

  def custom_board_size?
    puts "⬛️ Would you like to make your own board?\nPress 'y' for yes, or 'n' for no."
  end

  def enter_ship_length
    puts "⬛️ Enter the length of your ship below:\n"
  end

  def make_another_ship?
    puts "⬛️ Would you like to make another ship?\n⬛️Please enter 'y' for yes, or 'n' for no.\n"
  end

  def enter_board_width
    puts "⬛️ Enter the width of your board below (up to 10 spaces).\nFor example, '10' for a board tht is 10 spaces wide."
  end

  def enter_board_height
    puts "⬛️ Enter the height of your board below (up to 10 spaces).\nFor example, '10' for a board tht is 10 spaces tall."
  end

  def ships_to_be_placed
    puts "⬛️ Your fleet includes the ships below:\n"
  end

  def place_your_ship
    puts "🟨 ⬇ Enter the coordinates for the #{@ship.name} (#{@ship.length} coordinates).\n🟨 For example: 'A1 A2 A3'"
  end

  def invalid_coordinates
    puts "❗️You entered #{@input}.\n❗️Those are invalid coordinates.\n❗️Please try again..."
  end

  def invalid_coordinate
    puts "❗️#{@input} is not a valid coordinate.\n❗️Please enter a valid coordinate... "
  end

  def invalid_shot
    puts "❓You can't shoot there.\n❓Maybe try a different coordinate:"
  end

  def already_shot_here
    puts "❗️❓You already shot there.\nMaybe try a coordinate that hasn't been shot at yet:\n"
  end

  def your_shot
    puts "⬇ Enter the coordinate for your shot:\n"
  end

  def line_break
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def let_games_begin
    line_break
    puts "⬛️⬛️L⬛️E⬛️T⬛️⬛️T⬛️H⬛️E⬛️⬛️G⬛️A⬛️M⬛️E⬛️S⬛️⬛️B⬛️E⬛️G⬛️I⬛️N⬛️⬛️"
  end

  def buhbye
    line_break
    line_break
    puts "⬛️⬛️⬛️⬛️⬛️⬛️B⬛️U⬛️H⬛️-⬛️B⬛️Y⬛️E⬛️⬛️N⬛️O⬛️W⬛️!⬛️!⬛️⬛️⬛️⬛️⬛️⬛️"
    line_break
    line_break
  end

  def board_header
    line_break
    puts "⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️#{@player.name}'s Board⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️⬜️"
  end

  def computer_header
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️Computer's Board⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def missed_shot
    puts "⬜️⬜️⬜️⬜️⬜️⬜️👎 Your shot on #{@input} was a miss.👎"
  end

  def hit_shot
    puts "⬜️⬜️⬜️⬜️⬜️⬜️💥 Your shot on #{@input} was a hit.💥"
  end

  def sunk_shot
    puts "⬜️⬜️⬜️⬜️⬜️⬜️💀 Your shot on #{@input} sunk my ship.💀"
  end

  def computer_missed_shot(shot)
    puts "⬛️⬛️⬛️⬛️⬛️⬛️👎 My shot on #{shot} was a miss.👎"
  end

  def computer_made_shot(shot)
    puts "⬛️⬛️⬛️⬛️⬛️⬛️💥 My shot on #{shot} was a hit.💥"
  end

  def computer_sunk_shot(shot)
    puts "⬛️⬛️⬛️⬛️⬛️⬛️💀 My shot on #{shot} sunk your ship!💀"
  end

  def game_over(winner)
    puts "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
    puts "🎉#{winner} won!🎉"
    puts "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
  end
end
