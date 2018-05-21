require './test/test_helper'
require './lib/battleship'
require './lib/game_board'
require './lib/board_display'

class BattleShipTest < Minitest::Test
  def setup
    computer  = GameBoard.new
    humanoid   = GameBoard.new
    @battleship = Battleship.new(humanoid, computer)
  end

  def test_setup_instances
    assert_instance_of Battleship, @battleship
    assert_instance_of GameBoard, @battleship.player_board
    assert_instance_of GameBoard, @battleship.computer_board
  end

  def test_setup_of_player_board
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    expected = [['a1', 'a2', 'a3', 'x'],\
                ['b1', 'b2', 'x', 'x'],\
                ['c1', 'c2', 'x', 'c4'],\
                ['d1', 'd2', 'x', 'd4']]

    actual   = @battleship.player_board.rows

    assert_equal expected, actual
  end

  def test_grid_points
    assert_equal [0, 0], @battleship.grid_positions[:a1]
    assert_equal [3, 3], @battleship.grid_positions[:d4]
  end

  def test_player_retrieve_grid_position
    player_guess = 'A1'
    grid_value = @battleship.player_retrieve_grid_position(player_guess)

    assert_equal [0, 0], grid_value
  end

  def test_computer_retrieve_grid_value
    computer_guess = @battleship.computer_retrieve_grid_position

    assert_equal Array, computer_guess.class
    assert_equal 2, computer_guess.length
  end
end
