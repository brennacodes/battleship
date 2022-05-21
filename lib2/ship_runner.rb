puts 'Please choose your board width (a number from 1-20):'
width = gets.chomp.to_i
puts 'Please choose your board height (a number from 1-20):'
height = gets.chomp.to_i
height = (height += 65).chr

#inputs would go into the board creation as arguments
board = Board.new(width, height)


# The Board object has default values for width and height,
# so, if you create a Board.new object, it will create a
# normal 4 x 4 board.

def ship_build
  puts "Would you like to make your own custom ship?"
  puts "Press Y to build one, or S to skip:"
  ship_request = gets.chomp.to_s.downcase
  if ship_request[0] != "s"
    ship_size
  end
  puts "Your loss, sucker"
  submarine = Ship.new("Submarine", 2)
  cruiser = Ship.new("Cruiser", 3)
end

def ship_size
  puts "How long of a ship do you want to make?"
  size = gets.chomp.to_i
  if size >
    # the code below will need to be tinkered with to get the logic dialed in
    # and will slide in the line above
    # player_board.height || player_board.length
    puts "That's too big, choose again"
    ship_size
  end
  ship_name
end

def ship_name
  puts "What is the name of your ship?"
  name = gets.chomp.to_s
  name = Ship.new(name, size)
  puts "Would you like to build another ship?"
  puts "Press Y to build another one, or S to skip:"
  ship_request_2 = gets.chomp.to_s.downcase
    if ship_request_2[0] != "s"
      ship_size
    end
  puts "I hope you had fun building ships"
end
