require './test/test_helper'
require './lib/game_display'

class GameDisplayTest < Minitest::Test
  def test_it_exists
    @gd = GameDisplay.new

    assert_instance_of GameDisplay, @gd
  end
end
