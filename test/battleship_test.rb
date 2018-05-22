require './test/test_helper'
require './lib/battleship'
require './lib/game_board'
require './lib/game_display'

class BattleShipTest < Minitest::Test
  def setup
    computer  = GameBoard.new
    humanoid  = GameBoard.new
    display   = GameDisplay.new
    @battleship = Battleship.new(humanoid, computer, display)
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

  def test_setup_of_computer_board
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    count_ship_points = @battleship.computer_board.rows.flatten.count('x')

    assert_equal 5, count_ship_points
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

  def test_battleship_hit
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    shot_guess_1 = 'a4'
    shot_1 = @battleship.player_retrieve_grid_position(shot_guess_1)

    assert @battleship.player_battleship_hit?(shot_1)

    shot_guess_1 = 'd1'
    shot_1 = @battleship.player_retrieve_grid_position(shot_guess_1)

    refute @battleship.player_battleship_hit?(shot_1)
  end

  def test_mark_hit_player_ship
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    shot_guess_1 = 'a4'
    shot_1 = @battleship.player_retrieve_grid_position(shot_guess_1)
    hit   = @battleship.player_battleship_hit?(shot_1)

    @battleship.mark_hit_player_ship(hit, shot_1)

    expected = [['a1', 'a2', 'a3', 'o'],\
                ['b1', 'b2', 'x', 'x'],\
                ['c1', 'c2', 'x', 'c4'],\
                ['d1', 'd2', 'x', 'd4']]

    actual   = @battleship.player_board.rows

    assert_equal expected, actual
  end

  def test_player_battleship_size_2_sunk?
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    shot_guess_1 = 'a4'
    shot_1 = @battleship.player_retrieve_grid_position(shot_guess_1)
    hit   = @battleship.player_battleship_hit?(shot_1)

    @battleship.mark_hit_player_ship(hit, shot_1)

    refute @battleship.player_battleship_sunk?(pick_1)

    shot_guess_2 = 'b4'
    shot_2 = @battleship.player_retrieve_grid_position(shot_guess_2)
    hit   = @battleship.player_battleship_hit?(shot_2)

    @battleship.mark_hit_player_ship(hit, shot_2)

    assert @battleship.player_battleship_sunk?(pick_1)
  end

  def test_battleship_size_3_sunk?
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    shot_guess_1 = 'b3'
    shot_1 = @battleship.player_retrieve_grid_position(shot_guess_1)
    hit   = @battleship.player_battleship_hit?(shot_1)

    @battleship.mark_hit_player_ship(hit, shot_1)

    shot_guess_2 = 'c3'
    shot_2 = @battleship.player_retrieve_grid_position(shot_guess_2)
    hit   = @battleship.player_battleship_hit?(shot_2)

    @battleship.mark_hit_player_ship(hit, shot_2)

    refute @battleship.player_battleship_sunk?(pick_2)

    shot_guess_3 = 'd3'
    shot_3 = @battleship.player_retrieve_grid_position(shot_guess_3)
    hit   = @battleship.player_battleship_hit?(shot_3)

    @battleship.mark_hit_player_ship(hit, shot_3)

    assert @battleship.player_battleship_sunk?(pick_2)
  end

  def test_count_hits
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    shot_guess_1 = 'b3'
    shot_1 = @battleship.player_retrieve_grid_position(shot_guess_1)
    hit   = @battleship.player_battleship_hit?(shot_1)

    @battleship.mark_hit_player_ship(hit, shot_1)

    shot_guess_2 = 'c3'
    shot_2 = @battleship.player_retrieve_grid_position(shot_guess_2)
    hit   = @battleship.player_battleship_hit?(shot_2)

    @battleship.mark_hit_player_ship(hit, shot_2)

    shot_guess_3 = 'd3'
    shot_3 = @battleship.player_retrieve_grid_position(shot_guess_3)
    hit   = @battleship.player_battleship_hit?(shot_3)

    @battleship.mark_hit_player_ship(hit, shot_3)

    shot_guess_4 = 'a1'
    shot_4 = @battleship.player_retrieve_grid_position(shot_guess_4)
    hit   = @battleship.player_battleship_hit?(shot_4)

    @battleship.mark_hit_player_ship(hit, shot_4)

    shot_guess_5 = 'a4'
    shot_5 = @battleship.player_retrieve_grid_position(shot_guess_5)
    hit   = @battleship.player_battleship_hit?(shot_5)

    @battleship.mark_hit_player_ship(hit, shot_5)

    assert_equal 4, @battleship.count_hits
  end
end
