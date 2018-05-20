require './test/test_helper'
require './lib/board_display'

class BoardDisplayTest < Minitest::Test
  def test_it_exists
    @bd = BoardDisplay.new

    assert_instance_of BoardDisplay, @bd
  end
end
