require './test/test_helper'
require './lib/battleship'
require './lib/game_board'
require './lib/board_display'

class BattleShipTest < Minitest::Test
  def setup
    @battleship = Battleship.new

    @computer = GameBoard.new

    @humanoid = GameBoard.new
  end

  def test_setup_instances
    assert_instance_of Battleship, @battleship
    assert_instance_of GameBoard, @computer
    assert_instance_of GameBoard, @humanoid
  end

  def test_grid_points
    assert_equal [0, 0], @battleship.grid_positions[:a1]
    assert_equal [3, 3], @battleship.grid_positions[:d4]
  end

  def test_retrieve_grid_value
    player_guess = 'A1'
    grid_value = @battleship.retrieve_grid_value(player_guess)

    assert_equal [0, 0], grid_value
  end
end
