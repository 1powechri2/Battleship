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
    @counter = 0
  end

  def welcome
    welcome_message
    welcome = gets.chomp
    if welcome.downcase == 'p'
      setup_computer
    elsif welcome.downcase == 'i'
      instructions
      instruct = gets.chomp
      if instruct == 'p'
        setup_computer
      elsif instruct == 'q'
        puts 'Goodbye'
      end
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

    @player_board.place_ship(@play_ship_size_2)
    @player_board.place_ship(@play_ship_size_3)

    @game.humanoid_game_display_records_ships(@play_ship_size_2)
    @game.humanoid_game_display_records_ships(@play_ship_size_3)

    game_loop
  end

  def game_loop
    loop do
      @counter += 1
      puts ' PLAYER'
      puts "#{@game.humanoid_game_display.print_to_screen}"
      puts 'COMPUTER'
      puts "#{@game.computer_game_display.print_to_screen}"
      # player turn
      print 'Player Fire!!! >'
      guess = gets.chomp
      shot_position = @game.player_retrieve_grid_position(guess)
      hit = @game.computer_battleship_hit?(shot_position)
      @game.mark_hit_computer_ship(hit, shot_position)
      @game.computer_game_display_hits_and_misses(hit, shot_position)

      if hit == true
        puts "You've hit my battleship!!!"
      else
        puts "You've Missed"
      end

      sunk_1 = @game.computer_battleship_sunk?(@comp_ship_size_2)
      sunk_2 = @game.computer_battleship_sunk?(@comp_ship_size_3)

      if sunk_1 == true
        puts "You've sunk my small battleship!!!"
      end

      if sunk_2 == true
        puts "You've sunk my large battleship!!!"
      end

      puts 'Are you ready for the computer to fire? Please hit the return key.'
      comp_fire = gets.chomp

      # computer turn
      cpu_shot_position = @game.computer_retrieve_grid_position
      strike = @game.player_battleship_hit?(cpu_shot_position)
      @game.mark_hit_player_ship(strike, cpu_shot_position)
      @game.humanoid_game_display_hits_and_misses(strike, cpu_shot_position)

      if strike == true
        puts "Your ship has been hit!!!"
      else
        puts "Your ships have been missed."
      end

      player_sunk_1 = @game.player_battleship_sunk?(@play_ship_size_2)
      player_sunk_2 = @game.player_battleship_sunk?(@play_ship_size_3)

      if player_sunk_1 == true
        puts "Your small battleship has been sunk!!!"
      end

      if player_sunk_2 == true
        puts "Your large battleship has been sunk!!!"
      end

      if @game.count_computer_hits == 5
        puts "You're Awesome!!!"
        puts "It took #{@counter} shots to win."
        break
      elsif @game.count_player_hits == 5
        puts "You Suck!!!"
        puts "It took #{@counter} shots to lose."
        break
      end
    end
  end
end

play_battleship = Battleship.new
play_battleship.welcome
