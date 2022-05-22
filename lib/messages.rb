module Messages
  def welcome
    puts "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
  end

  def add_player
    puts "Please type your name.\nPress `Enter` to continue."
  end

  def begin_message
    puts "I have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is 3 units long and the Submarine is 2 units long."
  end

  def ships_to_be_placed
    puts "Your fleet includes the ships below:\n"
  end

  def place_ship
    puts "Enter the coordinates for the #{p1_ship_name(0)} (#{@player.fleet[0].length} coordinates).\nFor example: 'A1 A2 A3'"
  end

  def invalid_coordinates
    puts "❗️You entered #{@input}.\n❗️Those are invalid coordinates.\n❗️Please try again..."
  end

  def your_shot
    puts "Enter the coordinate for your shot:\n> "
  end

  def invalid_shot
    puts "#{coordinate} is not a valid coordinate.\nPlease enter a valid coordinate:\n> "
  end

  def line_break
    puts "================================================"
  end

  def board_header
    puts "=============#{current_player}'s BOARD============="
  end

  def shot_result
    puts "Your shot on #{@input} was a miss."
  end

  def computer_missed_shot
    puts "My shot on #{shot} was a miss."
  end

  def computer_made_shot
    puts "My shot on #{shot} was a hit."
  end

  def end_game
    puts "#{winner} won!"
  end
end
