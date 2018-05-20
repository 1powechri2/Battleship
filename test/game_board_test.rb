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

  def test_pick_ship_placement_size_2
    assert_equal 2, @board.pick_ship_placement_size_2.length
  end

  def test_pick_ship_placement_size_3
    ship_size_2 = @board.pick_ship_placement_size_2
    ship_size_3 = @board.pick_ship_placement_size_3(ship_size_2)

    assert_equal 3, ship_size_3.length
  end

  def test_ships_do_not_overlap
    ship_size_2 = @board.pick_ship_placement_size_2
    ship_size_3 = @board.pick_ship_placement_size_3(ship_size_2)

    refute ship_size_3.include? ship_size_2[0]
    refute ship_size_3.include? ship_size_2[1]
  end

  def test_place_ship_size_2
    @board.place_ship_size_2(['c2', 'c3'])

    assert @board.rows[2][1] == 'x'
    assert @board.rows[2][2] == 'x'
  end

  def test_place_ship_size_2_will_not_accept_smaller_or_larger_ships
    @board.place_ship_size_2(['c2', 'c3', 'c4'])

    refute @board.rows[2][1] == 'x'
    refute @board.rows[2][2] == 'x'
    refute @board.rows[2][3] == 'x'
  end

  # def test_place_ship_size_3
  #   @board.place_ship_size_2(['c2', 'c3', 'c4'])
  #
  #   assert @board.rows[2][1] == 'x'
  #   assert @board.rows[2][2] == 'x'
  #   assert @board.rows[2][3] == 'x'
  # end
end
