require './test/test_helper'
require './lib/game_board'

class GameBoardTest < Minitest::Test
  def setup
    @board = GameBoard.new
  end

  def test_it_exists
    assert_instance_of GameBoard, @board
  end

  def test_it_is_4x4_2_dimensional_array
    actual   = @board.rows
    expected = [['a1', 'a2', 'a3', 'a4'],\
                ['b1', 'b2', 'b3', 'b4'],\
                ['c1', 'c2', 'c3', 'c4'],\
                ['d1', 'd2', 'd3', 'd4']]

    assert_equal expected, actual
  end

  def test_space_designation
    assert_equal 'a1', @board.rows[0][0]
  end

  def test_change_space_objects
    @board.change_space_objects(['c2', 'c3'])

    assert_equal 'x', @board.rows[2][1]
    assert_equal 'x', @board.rows[2][2]
  end
end
