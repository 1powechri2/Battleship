require './lib/game_board'
require './lib/game_display'
require './lib/battleship_methods'

player_board     = GameBoard.new
computer_board   = GameBoard.new
player_display   = GameDisplay.new
computer_display = GameDisplay.new
# SET COMPUTER SHIPS AND PLACE
ship_size_2 = computer_board.pick_ship_placement_size_2_for_computer
no_overlap  = computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
ship_size_3 = computer_board.pick_ship_placement_size_3_for_computer(no_overlap)

computer_board.place_ship(ship_size_2)
computer_board.place_ship(ship_size_3)
# SET PLAYER SHIPS AND PLACE
puts 'select coordinates for a ship with two coordinates'
player_ship_size_2 = gets.chomp
p_ship_size_2 = player_board.pick_ship_placement_size_2_for_human(player_ship_size_2)
player_ship_size_3 = gets.chomp
no_overlap = player_board.ship_size_2_will_not_overlap_ship_size_3(p_ship_size_2)
p_ship_size_3 = player_board.pick_ship_placement_size_3_for_human(no_overlap, player_ship_size_3)

game = BattleshipMethods.new(player_board,computer_board,\
                             computer_display, player_display)

game.humanoid_game_display_records_ships(p_ship_size_2)
game.humanoid_game_display_records_ships(p_ship_size_3)

puts ' PLAYER'
puts "#{game.humanoid_game_display.print_to_screen}"
puts 'COMPUTER'
puts "#{game.computer_game_display.print_to_screen}"
