class GameDisplay
  attr_reader :rows,
              :display_positions

  def initialize
    @header = '.A B C D'
    @rows   = ['1       ',\
               '2       ',\
               '3       ',\
               '4       ']
    @display_positions = {a1:[0, 1], b1:[0, 3], c1:[0, 5], d1:[0, 7],\
                          a2:[1, 1], b2:[1, 3], c2:[1, 5], d2:[1, 7],\
                          a3:[2, 1], b3:[2, 3], c3:[2, 5], d3:[2, 7],\
                          a4:[3, 1], b4:[3, 3], c4:[3, 5], d4:[3, 7]}
  end

  def print_to_screen
    puts @header
    puts @rows[0]
    puts @rows[1]
    puts @rows[2]
    puts @rows[3]
  end
end
