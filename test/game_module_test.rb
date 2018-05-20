require './test/test_helper'
require './lib/game_module'

class GameModuleTest < Minitest::Test
  def test_pick_ship_placement_size_2
    assert_equal 2, pick_ship_placement_size_2.length
  end

  def test_pick_ship_placement_size_3
    ship_size_2 = pick_ship_placement_size_2
    ship_size_3 = pick_ship_placement_size_3(ship_size_2)

    assert_equal 3, ship_size_3.length
  end

  def test_ships_do_not_overlap
    ship_size_2 = pick_ship_placement_size_2
    ship_size_3 = pick_ship_placement_size_3(ship_size_2)
binding.pry
    refute ship_size_3.include? ship_size_2[0]
    refute ship_size_3.include? ship_size_2[1]
  end
end
