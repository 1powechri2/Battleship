require './lib/game_board'
require './lib/game_display'
require './lib/battleship_methods'
require './lib/messages'
require 'pry'

class Battleship
  include Messages

  def initialize
    @player_board     = GameBoard.new
    @computer_board   = GameBoard.new
    @player_display   = GameDisplay.new
    @computer_display = GameDisplay.new
    @game = BattleshipMethods.new(@player_board, @computer_board,\
                                  @computer_display, @player_display)
    @comp_ship_size_2 = nil
    @comp_ship_size_3 = nil
    @play_ship_size_2 = nil
    @play_ship_size_3 = nil
  end

  def welcome
    welcome_message
    welcome = gets.chomp
    if welcome.downcase == 'p'
      setup_computer
    elsif welcome.downcase == 'i'
      instructions
    elsif welcome.downcase == 'q'
      puts 'Goodbye'
    end
  end

  def setup_computer
    @comp_ship_size_2 = @computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @computer_board.ship_size_2_will_not_overlap_ship_size_3(@comp_ship_size_2)
    @comp_ship_size_3 = @computer_board.pick_ship_placement_size_3_for_computer(no_overlap)

    @computer_board.place_ship(@comp_ship_size_2)
    @computer_board.place_ship(@comp_ship_size_3)
    setup_player
  end

  def setup_player
    enter_ships_prompt
    player_ship_size_2 = gets.chomp
    @play_ship_size_2 = @player_board.pick_ship_placement_size_2_for_human(player_ship_size_2)
    pick_ship_size_3_message
    player_ship_size_3 = gets.chomp
    no_overlap = @player_board.ship_size_2_will_not_overlap_ship_size_3(@play_ship_size_2)
    @play_ship_size_3 = @player_board.pick_ship_placement_size_3_for_human(no_overlap, player_ship_size_3)

    @game.humanoid_game_display_records_ships(@play_ship_size_2)
    @game.humanoid_game_display_records_ships(@play_ship_size_3)

    game_loop
  end

  def game_loop
    loop do
      puts ' PLAYER'
      puts "#{@game.humanoid_game_display.print_to_screen}"
      puts 'COMPUTER'
      puts "#{@game.computer_game_display.print_to_screen}"

      print 'Player Fire!!! >'
      guess = gets.chomp
      shot_position = @game.player_retrieve_grid_position(guess)
      hit = @game.computer_battleship_hit?(shot_position)
      @game.mark_hit_computer_ship(hit, shot_position)
      @game.computer_game_display_hits_and_misses(hit, shot_position)

      if hit == true
        puts "You've hit my battleship!!!"
        puts "You've hit my battleship!!!"
        puts "You've hit my battleship!!!"
      else
        puts "You've Missed"
      end

      sunk_1 = @game.computer_battleship_sunk?(@comp_ship_size_2)
      sunk_2 = @game.computer_battleship_sunk?(@comp_ship_size_3)

      if sunk_1 == true
        puts "You've sunk my battleship!!!"
        puts "You've sunk my battleship!!!"
        puts "You've sunk my battleship!!!"
      end

      if sunk_2 == true
        puts "You've sunk my battleship!!!"
        puts "You've sunk my battleship!!!"
        puts "You've sunk my battleship!!!"
      end

      if @game.count_computer_hits == 5
        puts "You're Awesome"
        break
      elsif @game.count_player_hits == 5
        puts "You Suck"
        break
      end
    end
  end
end

play_battleship = Battleship.new
play_battleship.welcome
