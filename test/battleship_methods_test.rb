require './test/test_helper'
require './lib/battleship_methods'
require './lib/game_board'
require './lib/game_display'

class BattleshipMethodsTest < Minitest::Test
  def setup
    computer           = GameBoard.new
    humanoid           = GameBoard.new
    computer_display   = GameDisplay.new
    humanoid_display   = GameDisplay.new
    @battleship = BattleshipMethods.new(humanoid, computer, computer_display,\
                                 humanoid_display)
  end

  def test_setup_instances
    assert_instance_of BattleshipMethods, @battleship
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

    expected = [['a1', 'b1', 'c1', 'd1'],\
                ['a2', 'b2', 'c2', 'd2'],\
                ['a3', 'x', 'x', 'x'],\
                ['x', 'x', 'c4', 'd4']]

    actual   = @battleship.player_board.rows

    assert_equal expected, actual
  end

  def test_setup_of_computer_board
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    count_computer_board  = @battleship.computer_board.rows.flatten.count

    assert_equal 16, count_computer_board

    count_ship_hit_points = @battleship.computer_board.rows.flatten.count('x')

    assert_equal 5, count_ship_hit_points
  end

  def test_grid_points
    assert_equal [0, 0], @battleship.grid_positions[:a1]
    assert_equal [3, 3], @battleship.grid_positions[:d4]
  end

  def test_player_has_guesses
    assert_equal 16, @battleship.player_guesses.length
  end

  def test_computer_has_guesses
    assert_equal 16, @battleship.comp_guesses.length
  end

  def test_player_retrieve_grid_position
    player_guess = 'A1'
    grid_value = @battleship.player_retrieve_grid_position(player_guess)

    assert_equal [0, 0], grid_value
  end

  def test_player_guess_deleted_after_guessed
    player_guess = 'A1'
    grid_value = @battleship.player_retrieve_grid_position(player_guess)

    refute @battleship.player_guesses.include? 'a1'
  end

  def test_computer_retrieve_grid_position
    computer_guess = @battleship.computer_retrieve_grid_position

    assert_equal Array, computer_guess.class
    assert_equal 2, computer_guess.length
    assert_equal Integer, computer_guess[0].class
    assert_equal Integer, computer_guess[1].class
  end

  def test_computer_guess_deleted_after_guessed
    comp_guess = @battleship.computer_retrieve_grid_position

    refute @battleship.comp_guesses.include? comp_guess
  end

  def test_player_battleship_hit
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    computer_mock_shot = [3, 0]

    assert @battleship.player_battleship_hit?(computer_mock_shot)
  end

  def test_mark_hit_player_ship
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    comp_shot = [3, 0]

    hit = @battleship.player_battleship_hit?(comp_shot)

    @battleship.mark_hit_player_ship(hit, comp_shot)

    expected = [['a1', 'b1', 'c1', 'd1'],\
                ['a2', 'b2', 'c2', 'd2'],\
                ['a3', 'x', 'x', 'x'],\
                ['o', 'x', 'c4', 'd4']]

    actual   = @battleship.player_board.rows

    assert_equal expected, actual
  end

  def  test_mark_hit_computer_ship
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    player_guess_1 = 'a1'
    player_guess_2 = 'b2'
    player_guess_3 = 'c3'
    player_guess_4 = 'd4'
    player_guess_5 = 'd1'
    player_guess_6 = 'c2'
    player_guess_7 = 'b3'
    player_guess_8 = 'a4'

    shot_pos_1 = @battleship.player_retrieve_grid_position(player_guess_1)
    shot_pos_2 = @battleship.player_retrieve_grid_position(player_guess_2)
    shot_pos_3 = @battleship.player_retrieve_grid_position(player_guess_3)
    shot_pos_4 = @battleship.player_retrieve_grid_position(player_guess_4)
    shot_pos_5 = @battleship.player_retrieve_grid_position(player_guess_5)
    shot_pos_6 = @battleship.player_retrieve_grid_position(player_guess_6)
    shot_pos_7 = @battleship.player_retrieve_grid_position(player_guess_7)
    shot_pos_8 = @battleship.player_retrieve_grid_position(player_guess_8)

    shot_1 = @battleship.computer_battleship_hit?(shot_pos_1)
    shot_2 = @battleship.computer_battleship_hit?(shot_pos_2)
    shot_3 = @battleship.computer_battleship_hit?(shot_pos_3)
    shot_4 = @battleship.computer_battleship_hit?(shot_pos_4)
    shot_5 = @battleship.computer_battleship_hit?(shot_pos_5)
    shot_6 = @battleship.computer_battleship_hit?(shot_pos_6)
    shot_7 = @battleship.computer_battleship_hit?(shot_pos_7)
    shot_8 = @battleship.computer_battleship_hit?(shot_pos_8)

    @battleship.mark_hit_computer_ship(shot_1, shot_pos_1)
    @battleship.mark_hit_computer_ship(shot_2, shot_pos_2)
    @battleship.mark_hit_computer_ship(shot_3, shot_pos_3)
    @battleship.mark_hit_computer_ship(shot_4, shot_pos_4)
    @battleship.mark_hit_computer_ship(shot_5, shot_pos_5)
    @battleship.mark_hit_computer_ship(shot_6, shot_pos_6)
    @battleship.mark_hit_computer_ship(shot_7, shot_pos_7)
    @battleship.mark_hit_computer_ship(shot_8, shot_pos_8)

    assert @battleship.computer_board.rows.flatten.include? 'o'
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

    refute @battleship.player_battleship_sunk?(ship_size_2)

    shot_guess_2 = 'b4'
    shot_2 = @battleship.player_retrieve_grid_position(shot_guess_2)
    hit   = @battleship.player_battleship_hit?(shot_2)

    @battleship.mark_hit_player_ship(hit, shot_2)

    assert @battleship.player_battleship_sunk?(ship_size_2)
  end

  def test_player_battleship_size_3_sunk?
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

    refute @battleship.player_battleship_sunk?(ship_size_3)

    shot_guess_3 = 'd3'
    shot_3 = @battleship.player_retrieve_grid_position(shot_guess_3)
    hit   = @battleship.player_battleship_hit?(shot_3)

    @battleship.mark_hit_player_ship(hit, shot_3)

    assert @battleship.player_battleship_sunk?(ship_size_3)
  end

  def test_computer_battleship_size_2_sunk?
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    player_guess_1  = 'a1'
    player_guess_2  = 'a2'
    player_guess_3  = 'a3'
    player_guess_4  = 'a4'
    player_guess_5  = 'b1'
    player_guess_6  = 'b2'
    player_guess_7  = 'b3'
    player_guess_8  = 'b4'
    player_guess_9  = 'c1'
    player_guess_10 = 'c2'
    player_guess_11 = 'c3'
    player_guess_12 = 'c4'
    player_guess_13 = 'd1'
    player_guess_14 = 'd2'
    player_guess_15 = 'd3'
    player_guess_16 = 'd4'

    shot_pos_1  = @battleship.player_retrieve_grid_position(player_guess_1)
    shot_pos_2  = @battleship.player_retrieve_grid_position(player_guess_2)
    shot_pos_3  = @battleship.player_retrieve_grid_position(player_guess_3)
    shot_pos_4  = @battleship.player_retrieve_grid_position(player_guess_4)
    shot_pos_5  = @battleship.player_retrieve_grid_position(player_guess_5)
    shot_pos_6  = @battleship.player_retrieve_grid_position(player_guess_6)
    shot_pos_7  = @battleship.player_retrieve_grid_position(player_guess_7)
    shot_pos_8  = @battleship.player_retrieve_grid_position(player_guess_8)
    shot_pos_9  = @battleship.player_retrieve_grid_position(player_guess_9)
    shot_pos_10 = @battleship.player_retrieve_grid_position(player_guess_10)
    shot_pos_11 = @battleship.player_retrieve_grid_position(player_guess_11)
    shot_pos_12 = @battleship.player_retrieve_grid_position(player_guess_12)
    shot_pos_13 = @battleship.player_retrieve_grid_position(player_guess_13)
    shot_pos_14 = @battleship.player_retrieve_grid_position(player_guess_14)
    shot_pos_15 = @battleship.player_retrieve_grid_position(player_guess_15)
    shot_pos_16 = @battleship.player_retrieve_grid_position(player_guess_16)

    shot_1  = @battleship.computer_battleship_hit?(shot_pos_1)
    shot_2  = @battleship.computer_battleship_hit?(shot_pos_2)
    shot_3  = @battleship.computer_battleship_hit?(shot_pos_3)
    shot_4  = @battleship.computer_battleship_hit?(shot_pos_4)
    shot_5  = @battleship.computer_battleship_hit?(shot_pos_5)
    shot_6  = @battleship.computer_battleship_hit?(shot_pos_6)
    shot_7  = @battleship.computer_battleship_hit?(shot_pos_7)
    shot_8  = @battleship.computer_battleship_hit?(shot_pos_8)
    shot_9  = @battleship.computer_battleship_hit?(shot_pos_9)
    shot_10 = @battleship.computer_battleship_hit?(shot_pos_10)
    shot_11 = @battleship.computer_battleship_hit?(shot_pos_11)
    shot_12 = @battleship.computer_battleship_hit?(shot_pos_12)
    shot_13 = @battleship.computer_battleship_hit?(shot_pos_13)
    shot_14 = @battleship.computer_battleship_hit?(shot_pos_14)
    shot_15 = @battleship.computer_battleship_hit?(shot_pos_15)
    shot_16 = @battleship.computer_battleship_hit?(shot_pos_16)

    @battleship.mark_hit_computer_ship(shot_1, shot_pos_1)
    @battleship.mark_hit_computer_ship(shot_2, shot_pos_2)
    @battleship.mark_hit_computer_ship(shot_3, shot_pos_3)
    @battleship.mark_hit_computer_ship(shot_4, shot_pos_4)
    @battleship.mark_hit_computer_ship(shot_5, shot_pos_5)
    @battleship.mark_hit_computer_ship(shot_6, shot_pos_6)
    @battleship.mark_hit_computer_ship(shot_7, shot_pos_7)
    @battleship.mark_hit_computer_ship(shot_8, shot_pos_8)
    @battleship.mark_hit_computer_ship(shot_9, shot_pos_9)
    @battleship.mark_hit_computer_ship(shot_10, shot_pos_10)
    @battleship.mark_hit_computer_ship(shot_11, shot_pos_11)
    @battleship.mark_hit_computer_ship(shot_12, shot_pos_12)
    @battleship.mark_hit_computer_ship(shot_13, shot_pos_13)
    @battleship.mark_hit_computer_ship(shot_14, shot_pos_14)
    @battleship.mark_hit_computer_ship(shot_15, shot_pos_15)
    @battleship.mark_hit_computer_ship(shot_16, shot_pos_16)

    assert @battleship.computer_battleship_sunk?(ship_size_2)
  end

  def test_computer_battleship_size_3_sunk?
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    player_guess_1  = 'a1'
    player_guess_2  = 'a2'
    player_guess_3  = 'a3'
    player_guess_4  = 'a4'
    player_guess_5  = 'b1'
    player_guess_6  = 'b2'
    player_guess_7  = 'b3'
    player_guess_8  = 'b4'
    player_guess_9  = 'c1'
    player_guess_10 = 'c2'
    player_guess_11 = 'c3'
    player_guess_12 = 'c4'
    player_guess_13 = 'd1'
    player_guess_14 = 'd2'
    player_guess_15 = 'd3'
    player_guess_16 = 'd4'

    shot_pos_1  = @battleship.player_retrieve_grid_position(player_guess_1)
    shot_pos_2  = @battleship.player_retrieve_grid_position(player_guess_2)
    shot_pos_3  = @battleship.player_retrieve_grid_position(player_guess_3)
    shot_pos_4  = @battleship.player_retrieve_grid_position(player_guess_4)
    shot_pos_5  = @battleship.player_retrieve_grid_position(player_guess_5)
    shot_pos_6  = @battleship.player_retrieve_grid_position(player_guess_6)
    shot_pos_7  = @battleship.player_retrieve_grid_position(player_guess_7)
    shot_pos_8  = @battleship.player_retrieve_grid_position(player_guess_8)
    shot_pos_9  = @battleship.player_retrieve_grid_position(player_guess_9)
    shot_pos_10 = @battleship.player_retrieve_grid_position(player_guess_10)
    shot_pos_11 = @battleship.player_retrieve_grid_position(player_guess_11)
    shot_pos_12 = @battleship.player_retrieve_grid_position(player_guess_12)
    shot_pos_13 = @battleship.player_retrieve_grid_position(player_guess_13)
    shot_pos_14 = @battleship.player_retrieve_grid_position(player_guess_14)
    shot_pos_15 = @battleship.player_retrieve_grid_position(player_guess_15)
    shot_pos_16 = @battleship.player_retrieve_grid_position(player_guess_16)

    shot_1  = @battleship.computer_battleship_hit?(shot_pos_1)
    shot_2  = @battleship.computer_battleship_hit?(shot_pos_2)
    shot_3  = @battleship.computer_battleship_hit?(shot_pos_3)
    shot_4  = @battleship.computer_battleship_hit?(shot_pos_4)
    shot_5  = @battleship.computer_battleship_hit?(shot_pos_5)
    shot_6  = @battleship.computer_battleship_hit?(shot_pos_6)
    shot_7  = @battleship.computer_battleship_hit?(shot_pos_7)
    shot_8  = @battleship.computer_battleship_hit?(shot_pos_8)
    shot_9  = @battleship.computer_battleship_hit?(shot_pos_9)
    shot_10 = @battleship.computer_battleship_hit?(shot_pos_10)
    shot_11 = @battleship.computer_battleship_hit?(shot_pos_11)
    shot_12 = @battleship.computer_battleship_hit?(shot_pos_12)
    shot_13 = @battleship.computer_battleship_hit?(shot_pos_13)
    shot_14 = @battleship.computer_battleship_hit?(shot_pos_14)
    shot_15 = @battleship.computer_battleship_hit?(shot_pos_15)
    shot_16 = @battleship.computer_battleship_hit?(shot_pos_16)

    @battleship.mark_hit_computer_ship(shot_1, shot_pos_1)
    @battleship.mark_hit_computer_ship(shot_2, shot_pos_2)
    @battleship.mark_hit_computer_ship(shot_3, shot_pos_3)
    @battleship.mark_hit_computer_ship(shot_4, shot_pos_4)
    @battleship.mark_hit_computer_ship(shot_5, shot_pos_5)
    @battleship.mark_hit_computer_ship(shot_6, shot_pos_6)
    @battleship.mark_hit_computer_ship(shot_7, shot_pos_7)
    @battleship.mark_hit_computer_ship(shot_8, shot_pos_8)
    @battleship.mark_hit_computer_ship(shot_9, shot_pos_9)
    @battleship.mark_hit_computer_ship(shot_10, shot_pos_10)
    @battleship.mark_hit_computer_ship(shot_11, shot_pos_11)
    @battleship.mark_hit_computer_ship(shot_12, shot_pos_12)
    @battleship.mark_hit_computer_ship(shot_13, shot_pos_13)
    @battleship.mark_hit_computer_ship(shot_14, shot_pos_14)
    @battleship.mark_hit_computer_ship(shot_15, shot_pos_15)
    @battleship.mark_hit_computer_ship(shot_16, shot_pos_16)

    assert @battleship.computer_battleship_sunk?(ship_size_3)
  end

  def test_count_player_hits
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

    assert_equal 4, @battleship.count_player_hits
  end

  def test_count_computer_hits
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    player_guess_1  = 'a1'
    player_guess_2  = 'a2'
    player_guess_3  = 'a3'
    player_guess_4  = 'a4'
    player_guess_5  = 'b1'
    player_guess_6  = 'b2'
    player_guess_7  = 'b3'
    player_guess_8  = 'b4'
    player_guess_9  = 'c1'
    player_guess_10 = 'c2'
    player_guess_11 = 'c3'
    player_guess_12 = 'c4'
    player_guess_13 = 'd1'
    player_guess_14 = 'd2'
    player_guess_15 = 'd3'
    player_guess_16 = 'd4'

    shot_pos_1  = @battleship.player_retrieve_grid_position(player_guess_1)
    shot_pos_2  = @battleship.player_retrieve_grid_position(player_guess_2)
    shot_pos_3  = @battleship.player_retrieve_grid_position(player_guess_3)
    shot_pos_4  = @battleship.player_retrieve_grid_position(player_guess_4)
    shot_pos_5  = @battleship.player_retrieve_grid_position(player_guess_5)
    shot_pos_6  = @battleship.player_retrieve_grid_position(player_guess_6)
    shot_pos_7  = @battleship.player_retrieve_grid_position(player_guess_7)
    shot_pos_8  = @battleship.player_retrieve_grid_position(player_guess_8)
    shot_pos_9  = @battleship.player_retrieve_grid_position(player_guess_9)
    shot_pos_10 = @battleship.player_retrieve_grid_position(player_guess_10)
    shot_pos_11 = @battleship.player_retrieve_grid_position(player_guess_11)
    shot_pos_12 = @battleship.player_retrieve_grid_position(player_guess_12)
    shot_pos_13 = @battleship.player_retrieve_grid_position(player_guess_13)
    shot_pos_14 = @battleship.player_retrieve_grid_position(player_guess_14)
    shot_pos_15 = @battleship.player_retrieve_grid_position(player_guess_15)
    shot_pos_16 = @battleship.player_retrieve_grid_position(player_guess_16)

    shot_1  = @battleship.computer_battleship_hit?(shot_pos_1)
    shot_2  = @battleship.computer_battleship_hit?(shot_pos_2)
    shot_3  = @battleship.computer_battleship_hit?(shot_pos_3)
    shot_4  = @battleship.computer_battleship_hit?(shot_pos_4)
    shot_5  = @battleship.computer_battleship_hit?(shot_pos_5)
    shot_6  = @battleship.computer_battleship_hit?(shot_pos_6)
    shot_7  = @battleship.computer_battleship_hit?(shot_pos_7)
    shot_8  = @battleship.computer_battleship_hit?(shot_pos_8)
    shot_9  = @battleship.computer_battleship_hit?(shot_pos_9)
    shot_10 = @battleship.computer_battleship_hit?(shot_pos_10)
    shot_11 = @battleship.computer_battleship_hit?(shot_pos_11)
    shot_12 = @battleship.computer_battleship_hit?(shot_pos_12)
    shot_13 = @battleship.computer_battleship_hit?(shot_pos_13)
    shot_14 = @battleship.computer_battleship_hit?(shot_pos_14)
    shot_15 = @battleship.computer_battleship_hit?(shot_pos_15)
    shot_16 = @battleship.computer_battleship_hit?(shot_pos_16)

    @battleship.mark_hit_computer_ship(shot_1, shot_pos_1)
    @battleship.mark_hit_computer_ship(shot_2, shot_pos_2)
    @battleship.mark_hit_computer_ship(shot_3, shot_pos_3)
    @battleship.mark_hit_computer_ship(shot_4, shot_pos_4)
    @battleship.mark_hit_computer_ship(shot_5, shot_pos_5)
    @battleship.mark_hit_computer_ship(shot_6, shot_pos_6)
    @battleship.mark_hit_computer_ship(shot_7, shot_pos_7)
    @battleship.mark_hit_computer_ship(shot_8, shot_pos_8)
    @battleship.mark_hit_computer_ship(shot_9, shot_pos_9)
    @battleship.mark_hit_computer_ship(shot_10, shot_pos_10)
    @battleship.mark_hit_computer_ship(shot_11, shot_pos_11)
    @battleship.mark_hit_computer_ship(shot_12, shot_pos_12)
    @battleship.mark_hit_computer_ship(shot_13, shot_pos_13)
    @battleship.mark_hit_computer_ship(shot_14, shot_pos_14)
    @battleship.mark_hit_computer_ship(shot_15, shot_pos_15)
    @battleship.mark_hit_computer_ship(shot_16, shot_pos_16)

    assert_equal 5, @battleship.count_computer_hits
  end

  def test_humanoid_game_display_records_ships
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)

    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    @battleship.humanoid_game_display_records_ships(ship_size_2)
    @battleship.humanoid_game_display_records_ships(ship_size_3)

    expected = ['1       ',\
                '2       ',\
                '3  x x x',\
                '4x x    ']

    actual   = @battleship.humanoid_game_display.rows

    assert_equal expected, actual
  end

  def test_humanoid_game_display_records_hits_and_misses
    pick_1 = 'a4 b4'
    pick_2 = 'b3 c3 d3'
    ship_size_2 = @battleship.player_board.pick_ship_placement_size_2_for_human(pick_1)
    no_overlap  = @battleship.player_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.player_board.pick_ship_placement_size_3_for_human(no_overlap, pick_2)
    @battleship.player_board.place_ship(ship_size_2)
    @battleship.player_board.place_ship(ship_size_3)

    @battleship.humanoid_game_display_records_ships(ship_size_2)
    @battleship.humanoid_game_display_records_ships(ship_size_3)

    computer_shot_1 = [3, 0]
    computer_shot_2 = [1, 0]

    shot_1_hit = @battleship.player_battleship_hit?(computer_shot_1)
    shot_2_hit = @battleship.player_battleship_hit?(computer_shot_2)

    @battleship.humanoid_game_display_hits_and_misses(shot_1_hit, computer_shot_1)
    @battleship.humanoid_game_display_hits_and_misses(shot_2_hit, computer_shot_2)

    expected = ['1       ',\
                '2m      ',\
                '3  x x x',\
                '4o x    ']

    actual   = @battleship.humanoid_game_display.rows

    assert_equal expected, actual
  end

  def test_computer_game_display_hits_and_misses
    ship_size_2 = @battleship.computer_board.pick_ship_placement_size_2_for_computer
    no_overlap  = @battleship.computer_board.ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    ship_size_3 = @battleship.computer_board.pick_ship_placement_size_3_for_computer(no_overlap)
    @battleship.computer_board.place_ship(ship_size_2)
    @battleship.computer_board.place_ship(ship_size_3)

    player_guess_1  = 'a1'
    player_guess_2  = 'a2'
    player_guess_3  = 'a3'
    player_guess_4  = 'a4'
    player_guess_5  = 'b1'
    player_guess_6  = 'b2'
    player_guess_7  = 'b3'
    player_guess_8  = 'b4'
    player_guess_9  = 'c1'
    player_guess_10 = 'c2'
    player_guess_11 = 'c3'
    player_guess_12 = 'c4'
    player_guess_13 = 'd1'
    player_guess_14 = 'd2'
    player_guess_15 = 'd3'
    player_guess_16 = 'd4'

    shot_pos_1  = @battleship.player_retrieve_grid_position(player_guess_1)
    shot_pos_2  = @battleship.player_retrieve_grid_position(player_guess_2)
    shot_pos_3  = @battleship.player_retrieve_grid_position(player_guess_3)
    shot_pos_4  = @battleship.player_retrieve_grid_position(player_guess_4)
    shot_pos_5  = @battleship.player_retrieve_grid_position(player_guess_5)
    shot_pos_6  = @battleship.player_retrieve_grid_position(player_guess_6)
    shot_pos_7  = @battleship.player_retrieve_grid_position(player_guess_7)
    shot_pos_8  = @battleship.player_retrieve_grid_position(player_guess_8)
    shot_pos_9  = @battleship.player_retrieve_grid_position(player_guess_9)
    shot_pos_10 = @battleship.player_retrieve_grid_position(player_guess_10)
    shot_pos_11 = @battleship.player_retrieve_grid_position(player_guess_11)
    shot_pos_12 = @battleship.player_retrieve_grid_position(player_guess_12)
    shot_pos_13 = @battleship.player_retrieve_grid_position(player_guess_13)
    shot_pos_14 = @battleship.player_retrieve_grid_position(player_guess_14)
    shot_pos_15 = @battleship.player_retrieve_grid_position(player_guess_15)
    shot_pos_16 = @battleship.player_retrieve_grid_position(player_guess_16)

    shot_hit_1  = @battleship.computer_battleship_hit?(shot_pos_1)
    shot_hit_2  = @battleship.computer_battleship_hit?(shot_pos_2)
    shot_hit_3  = @battleship.computer_battleship_hit?(shot_pos_3)
    shot_hit_4  = @battleship.computer_battleship_hit?(shot_pos_4)
    shot_hit_5  = @battleship.computer_battleship_hit?(shot_pos_5)
    shot_hit_6  = @battleship.computer_battleship_hit?(shot_pos_6)
    shot_hit_7  = @battleship.computer_battleship_hit?(shot_pos_7)
    shot_hit_8  = @battleship.computer_battleship_hit?(shot_pos_8)
    shot_hit_9  = @battleship.computer_battleship_hit?(shot_pos_9)
    shot_hit_10 = @battleship.computer_battleship_hit?(shot_pos_10)
    shot_hit_11 = @battleship.computer_battleship_hit?(shot_pos_11)
    shot_hit_12 = @battleship.computer_battleship_hit?(shot_pos_12)
    shot_hit_13 = @battleship.computer_battleship_hit?(shot_pos_13)
    shot_hit_14 = @battleship.computer_battleship_hit?(shot_pos_14)
    shot_hit_15 = @battleship.computer_battleship_hit?(shot_pos_15)
    shot_hit_16 = @battleship.computer_battleship_hit?(shot_pos_16)

    @battleship.computer_game_display_hits_and_misses(shot_hit_1, shot_pos_1)
    @battleship.computer_game_display_hits_and_misses(shot_hit_2, shot_pos_2)
    @battleship.computer_game_display_hits_and_misses(shot_hit_3, shot_pos_3)
    @battleship.computer_game_display_hits_and_misses(shot_hit_4, shot_pos_4)
    @battleship.computer_game_display_hits_and_misses(shot_hit_5, shot_pos_5)
    @battleship.computer_game_display_hits_and_misses(shot_hit_6, shot_pos_6)
    @battleship.computer_game_display_hits_and_misses(shot_hit_7, shot_pos_7)
    @battleship.computer_game_display_hits_and_misses(shot_hit_8, shot_pos_8)
    @battleship.computer_game_display_hits_and_misses(shot_hit_9, shot_pos_9)
    @battleship.computer_game_display_hits_and_misses(shot_hit_10, shot_pos_10)
    @battleship.computer_game_display_hits_and_misses(shot_hit_11, shot_pos_11)
    @battleship.computer_game_display_hits_and_misses(shot_hit_12, shot_pos_12)
    @battleship.computer_game_display_hits_and_misses(shot_hit_13, shot_pos_13)
    @battleship.computer_game_display_hits_and_misses(shot_hit_14, shot_pos_14)
    @battleship.computer_game_display_hits_and_misses(shot_hit_15, shot_pos_15)
    @battleship.computer_game_display_hits_and_misses(shot_hit_16, shot_pos_16)

    assert_equal 5, @battleship.computer_game_display.rows.join.count('o')
    assert_equal 11, @battleship.computer_game_display.rows.join.count('m')
  end
end
