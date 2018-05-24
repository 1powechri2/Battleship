require './lib/messages'

class BattleshipMethods
  include Messages
  attr_reader :player_board,
              :computer_board,
              :computer_game_display,
              :humanoid_game_display,
              :grid_positions,
              :player_guesses,
              :comp_guesses

  def initialize(player_board, comp_board, computer_game_display,\
                 humanoid_game_display)

    @player_board = player_board
    @computer_board = comp_board
    @computer_game_display = computer_game_display
    @humanoid_game_display = humanoid_game_display
    @grid_positions = {a1:[0, 0], b1:[0, 1], c1:[0, 2], d1:[0, 3],\
                       a2:[1, 0], b2:[1, 1], c2:[1, 2], d2:[1, 3],\
                       a3:[2, 0], b3:[2, 1], c3:[2, 2], d3:[2, 3],\
                       a4:[3, 0], b4:[3, 1], c4:[3, 2], d4:[3, 3]}
    @player_guesses = ['a1','a2','a3','a4','b1','b2','b3','b4',\
                       'c1','c2','c3','c4','d1','d2','d3','d4']
    @comp_guesses   = [[0, 0], [0, 1], [0, 2], [0, 3],\
                       [1, 0], [1, 1], [1, 2], [1, 3],\
                       [2, 0], [2, 1], [2, 2], [2, 3],\
                       [3, 0], [3, 1], [3, 2], [3, 3]]
  end

  def player_retrieve_grid_position(guess)
    if @player_guesses.include? guess.downcase
      @player_guesses.delete(guess.downcase)
      return @grid_positions[guess.downcase.to_sym]
    else
      player_shot_error_message
      pick_again = gets.chomp
      player_retrieve_grid_position(pick_again)
    end
  end

  def computer_retrieve_grid_position
    guess = @comp_guesses.sample
    @comp_guesses.delete(guess)
    return guess
  end

  def player_battleship_hit?(shot)
    @player_board.rows[shot[0]][shot[1]] == 'x'
  end

  def computer_battleship_hit?(shot)
    @computer_board.rows[shot[0]][shot[1]] == 'x'
  end

  def mark_hit_player_ship(hit, shot_position)
    if hit == true
      @player_board.rows[shot_position[0]][shot_position[1]] = 'o'
    end
  end

  def mark_hit_computer_ship(hit, shot_position)
    if hit == true
      @computer_board.rows[shot_position[0]][shot_position[1]] = 'o'
    end
  end

  def player_battleship_sunk?(ship)
    ship.map do |coordinate|
      position = @grid_positions[coordinate.to_sym]
      @player_board.rows[position[0]][position[1]] == 'o'
    end.all?
  end

  def computer_battleship_sunk?(ship)
    ship.map do |coordinate|
      position = @grid_positions[coordinate.to_sym]
      @computer_board.rows[position[0]][position[1]] == 'o'
    end.all?
  end

  def count_player_hits
    @player_board.rows.flatten.count('o')
  end

  def count_computer_hits
    @computer_board.rows.flatten.count('o')
  end

  def humanoid_game_display_records_ships(ship)
    ship.each do |coordinate|
      position = @humanoid_game_display.display_positions[coordinate.to_sym]
      @humanoid_game_display.rows[position[0]][position[1]] = 'x'
    end
  end

  def humanoid_game_display_hits_and_misses(shot_hit, shot_coordinate)
    display_key = @grid_positions.key(shot_coordinate)
    display_point = @humanoid_game_display.display_positions[display_key]
    if shot_hit == true
      @humanoid_game_display.rows[display_point[0]][display_point[1]] = 'o'
    elsif shot_hit == false
      @humanoid_game_display.rows[display_point[0]][display_point[1]] = 'm'
    end
  end

  def computer_game_display_hits_and_misses(shot_hit, shot_coordinate)
    display_key = @grid_positions.key(shot_coordinate)
    display_point = @computer_game_display.display_positions[display_key]
    if shot_hit == true
      @computer_game_display.rows[display_point[0]][display_point[1]] = 'o'
    elsif shot_hit == false
      @computer_game_display.rows[display_point[0]][display_point[1]] = 'm'
    end
  end
end
