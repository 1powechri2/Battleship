class Battleship
  attr_reader :grid_positions,
              :player_board,
              :computer_board,
              :computer_game_display,
              :humanoid_game_display,
              :mock_computer_board

  def initialize(player_board, comp_board, computer_game_display,\
                 humanoid_game_display)
                 
    @player_board = player_board
    @computer_board = comp_board
    @computer_game_display = computer_game_display
    @humanoid_game_display = humanoid_game_display
    @mock_computer_board = [['a1', 'a2', 'a3', 'a4'],\
                            ['x', 'x', 'x', 'b4'],\
                            ['c1', 'c2', 'c3', 'c4'],\
                            ['x', 'x', 'd3', 'd4']]

    @grid_positions = {a1:[0, 0], a2:[0, 1], a3:[0, 2], a4:[0, 3],\
                       b1:[1, 0], b2:[1, 1], b3:[1, 2], b4:[1, 3],\
                       c1:[2, 0], c2:[2, 1], c3:[2, 2], c4:[2, 3],\
                       d1:[3, 0], d2:[3, 1], d3:[3, 2], d4:[3, 3]}
  end

  def player_retrieve_grid_position(guess)
    @grid_positions[guess.downcase.to_sym]
  end

  def computer_retrieve_grid_position
    @grid_positions.values.sample
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
      @pcomputer_board.rows[shot_position[0]][shot_position[1]] = 'o'
    end
  end

  def player_battleship_sunk?(ship)
    ship.split(' ').map do |coordinate|
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
end
