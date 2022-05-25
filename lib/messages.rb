module Messages
  def welcome
    puts "Welcome to BATTLESHIP\nType 'play' to play. Type 'quit' to quit at any time."
  end

  def add_player
    puts "Please type your name.\nPress `Enter` to continue."
  end

  def begin_message
    puts "⬛️ I have laid out my ships on my ✨super secret✨ board.\n⬛️ Now you need to lay out your two ships.\n⬛️ I am a computer, so I can 'technically' see your ships,\n⬛️ but I'm not actually 'looking'...👀\n⬛️ Promise."
  end

  def ships_to_be_placed
    puts "Your fleet includes the ships below:\n"
  end

  def place_your_ship
    puts "⬛️ ⬇ Enter the coordinates for the #{@ship.name} (#{@ship.length} coordinates).\n⬛️ For example: 'A1 A2 A3'"
  end

  def invalid_coordinates
    puts "❗️You entered #{@input}.\n❗️Those are invalid coordinates.\n❗️Please try again..."
  end

  def invalid_coordinate
    puts "❗️#{@input} is not a valid coordinate.\nPlease enter a valid coordinate:\n> "
  end

  def invalid_shot
    puts "❓You can't shoot there.\nMaybe try a different coordinate:\n> "
  end

  def your_shot
    puts "⬛️⬇ Enter the coordinate for your shot:\n"
  end

  def line_break
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def let_games_begin
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
    puts "⬛️⬛️L⬛️E⬛️T⬛️⬛️T⬛️H⬛️E⬛️⬛️G⬛️A⬛️M⬛️E⬛️S⬛️⬛️B⬛️E⬛️G⬛️I⬛️N⬛️⬛️"
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def buhbye
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
    puts "⬛️⬛️⬛️⬛️⬛️⬛️B⬛️U⬛️H⬛️-⬛️B⬛️Y⬛️E⬛️⬛️N⬛️O⬛️W⬛️!⬛️!⬛️⬛️⬛️⬛️⬛️⬛️"
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def board_header
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️#{@player.name}'s BOARD⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def computer_header
    puts "⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️COMPUTER's BOARD⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️⬛️"
  end

  def missed_shot
    puts "⬛️⬛️⬛️⬛️⬛️⬛️👎 Your shot on #{@input} was a miss.👎"
  end

  def hit_shot
    puts "⬛️⬛️⬛️⬛️⬛️⬛️💥 Your shot on #{@input} was a hit.💥"
  end

  def sunk_shot
    puts "⬛️⬛️⬛️⬛️⬛️⬛️💀 Your shot on #{@input} sunk my ship.💀"
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
