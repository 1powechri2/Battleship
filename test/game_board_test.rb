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

  def test_pick_ship_placement_size_2_for_computer
    assert_equal 2, @board.pick_ship_placement_size_2_for_computer.length
  end

  def test_ship_size_2_will_not_overlap_ship_size_3
    ship_size_2 = @board.pick_ship_placement_size_2_for_computer
    no_overlap = @board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)

    refute no_overlap.include? ship_size_2
  end

  def test_pick_ship_placement_size_3_for_computer
    ship_size_2 = @board.pick_ship_placement_size_2_for_computer
    no_overlap = @board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @board.pick_ship_placement_size_3_for_computer(no_overlap)

    assert_equal 3, ship_size_3.length
  end

  def test_computer_ships_do_not_overlap
    ship_size_2 = @board.pick_ship_placement_size_2_for_computer
    no_overlap = @board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @board.pick_ship_placement_size_3_for_computer(no_overlap)

    refute ship_size_3.include? ship_size_2[0]
    refute ship_size_3.include? ship_size_2[1]
  end

  def test_pick_ship_placement_size_2_for_human
    pick = 'A4 B4'
    ship_size_2 = @board.pick_ship_placement_size_2_for_human(pick)

    assert_equal ['a4', 'b4'], ship_size_2
  end

  def test_pick_ship_placement_size_3_for_human
    pick_1 = 'a4 b4'
    pick_2 = 'b3 C3 d3'
    ship_size_2 = @board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap = @board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)

    assert_equal ['b3', 'c3', 'd3'], ship_size_3
  end

  def test_place_ship_size_2
    @board.place_ship(['c2', 'c3'])

    assert @board.rows[2][1] == 'x'
    assert @board.rows[2][2] == 'x'
  end

  def test_place_ship_size_3
    @board.place_ship(['c2', 'c3', 'c4'])

    assert @board.rows[2][1] == 'x'
    assert @board.rows[2][2] == 'x'
    assert @board.rows[2][3] == 'x'
  end
end
