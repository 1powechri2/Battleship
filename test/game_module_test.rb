require './test/test_helper'
require './lib/game_module'

class GameModuleTest < Minitest::Test
  def test_pick_ship_placement_size_2
    assert_equal 2, pick_ship_placement_size_2.length
  end

  def test_pick_ship_placement_size_3
    assert_equal 3, pick_ship_placement_size_3.length
  end
end
