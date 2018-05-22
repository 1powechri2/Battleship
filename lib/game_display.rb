class GameDisplay
  attr_reader :rows,
              :display_positions

  def initialize
    @header = '.A B C D'
    @rows   = ['1       ',\
               '2       ',\
               '3       ',\
               '4       ']
    @display_positions = {a1:[0, 1], a2:[0, 3], a3:[0, 5], a4:[0, 7],\
                          b1:[1, 1], b2:[1, 3], b3:[1, 5], b4:[1, 7],\
                          c1:[2, 1], c2:[2, 3], c3:[2, 5], c4:[2, 7],\
                          d1:[3, 1], d2:[3, 3], d3:[3, 5], d4:[3, 7]}
  end

  def print_to_screen
    puts @header
    puts @rows[0]
    puts @rows[1]
    puts @rows[2]
    puts @rows[3]
  end
end
