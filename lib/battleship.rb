class Battleship
  attr_reader :grid_positions,
              :player_board,
              :computer_board

  def initialize(player_board, comp_board, game_display)
    @player_board = player_board
    @computer_board = comp_board
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

  def computer_battleship_hit?
    @computer_board.rows[shot[0]][shot[1]] == 'x'
  end

  def mark_hit_player_ship(hit, shot_position)
    if hit == true
      @player_board.rows[shot_position[0]][shot_position[1]] = 'o'
    end
  end

  def battleship_size_2_sunk?(ship)
    coord_1 = @grid_positions[ship.split(' ')[0].to_sym]
    coord_2 = @grid_positions[ship.split(' ')[1].to_sym]
    ship_keel = @player_board.rows[coord_1[0]][coord_1[1]]
    ship_bough = @player_board.rows[coord_2[0]][coord_2[1]]
    ship_keel == 'o' && ship_bough == 'o'
  end
end
