class BoardDisplay
  def initialize
    @header = '.A B C D'
    @rows   = ['1       ',\
               '2       ',\
               '3       ',\
               '4       ']
  end

  def print_to_screen
    puts @header
    puts @rows[0]
    puts @rows[1]
    puts @rows[2]
    puts @rows[3]
  end
end
