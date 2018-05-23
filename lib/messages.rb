module Messages
def welcome_message
  puts 'Welcome to BATTLESHIP

Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
end

def pick_ship_placement_size_2_error_messages
  puts "You have entered an incorrect guess\n
either your ship is placed off the board or\n
you forgot to put a space in between your\n
ship's coordinates. Try Again."
end

def pick_ship_placement_size_3_error_messages
  puts "You entered an incorrect guess\n
either your ship is placed off the board or\n
you forgot to put a space in between your\n
ship's coordinates or your ship is overlaping\n
your other ship. Try Again."
end

def pick_ship_size_2_message
  print 'select coordinates for a ship with two coordinates >'
end

def pick_ship_size_3_message
  print 'now select coordinates for a ship with three coordinates >'
end

end
