class Battleship
  attr_reader :grid_positions

  def initialize
    @grid_positions = {a1:[0, 0], a2:[0, 1], a3:[0, 2], a4:[0, 3],\
                       b1:[1, 0], b2:[1, 1], b3:[1, 2], b4:[1, 3],\
                       c1:[2, 0], c2:[2, 1], c3:[2, 2], c4:[2, 3],\
                       d1:[3, 0], d2:[3, 1], d3:[3, 2], d4:[3, 3]}
  end

  def retrieve_grid_value(guess)
    @grid_positions[guess.downcase.to_sym]
  end
end
