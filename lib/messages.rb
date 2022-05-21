module Messages
  def welome
    puts "Welcome to BATTLESHIP\n
          Enter p to play. Enter q to quit."
  end

  def add_player
    puts "Please type your name.\n
    Press `Enter` to continue."
  end

  def begin_message
    puts "I have laid out my ships on the grid.\n
    You now need to lay out your two ships.\n
    The Cruiser is 3 units long and the Submarine is 2 units long."
  end

  def ships_to_be_placed
    puts "Your fleet includes the ships below:\n
    #{p1_ships}"
  end

  def place_ship
    puts "Enter the coordinates for the #{player_ship[0].name} (#{player_ships[0].length} spaces).\n
    For example: 'A1 A2 A3'
    > "
  end

  def invalid_coordinates
    puts "You entered #{coordinates}.\n
    Those are invalid coordinates.\n
    Please try again:\n
    > "
  end

  def take_shot
    puts "Enter the coordinate for your shot:\n
    > "
  end

  def invalid_shot
    puts "#{coordinate} is not a valid coordinate.\n
    Please enter a valid coordinate:\n
    > "
  end

  def line_break
    puts "================================================"
  end

  def board_header
    puts "=============#{current_player}'s BOARD============="
  end

  def shot_result
    puts "Your shot on #{coordinate} was a miss."
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
