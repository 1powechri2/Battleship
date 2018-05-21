class GameBoard
  attr_reader :rows,
              :spaces

  def initialize
    @rows         = [['a1', 'a2', 'a3', 'a4'],\
                     ['b1', 'b2', 'b3', 'b4'],\
                     ['c1', 'c2', 'c3', 'c4'],\
                     ['d1', 'd2', 'd3', 'd4']]

    @ships_size_2 = [['a1', 'a2'], ['a2', 'a3'], ['a3', 'a4'],\
                     ['b1', 'b2'], ['b2', 'b3'], ['b3', 'b4'],\
                     ['c1', 'c2'], ['c2', 'c3'], ['c3', 'c4'],\
                     ['d1', 'd2'], ['d2', 'd3'], ['d3', 'd4'],\
                     ['a1', 'b1'], ['a2', 'b2'], ['a3', 'b3'],\
                     ['a4', 'b4'], ['b1', 'c1'], ['b2', 'c2'],\
                     ['b3', 'c3'], ['b4', 'c4'], ['c1', 'd1'],\
                     ['c2', 'd2'], ['c3', 'd3'], ['c4', 'd4']]

    @ships_size_3 = [['a1', 'a2', 'a3'], ['a2', 'a3', 'a4'],\
                     ['b1', 'b2', 'b3'], ['b2', 'b3', 'b4'],\
                     ['c1', 'c2', 'c3'], ['c2', 'c3', 'c4'],\
                     ['d1', 'd2', 'd3'], ['d2', 'd3', 'd4'],\
                     ['a1', 'b1', 'c1'], ['a2', 'b2', 'c2'],\
                     ['a3', 'b3', 'c3'], ['a4', 'b4', 'c4'],\
                     ['b1', 'c1', 'd1'], ['b2', 'c2', 'd2'],\
                     ['b3', 'c3', 'd3'], ['b4', 'c4', 'd4']]
  end

  def pick_ship_placement_size_2_for_computer
    @ships_size_2.sample
  end

  def pick_ship_placement_size_3_for_computer(ship_3)
    ship_3.compact.sample
  end

  def ship_size_2_will_not_overlap_ship_size_3(ship_size_2)
    @ships_size_3.map do |ship|
      if ship.include? ship_size_2[0]
        ship = nil
      elsif ship.include? ship_size_2[1]
        ship = nil
      else
        ship
      end
    end
  end

  def pick_ship_placement_size_2_for_human(pick)
    if @ships_size_2.include? pick.split(' ')
      return pick.split(' ')
    else
      puts "You entered an incorrect guess\n
      either your ship is placed off the board or\n
      you forgot to put a space in between your\n
      ship's coordinates. Try Again."
      pick_again = gets.chomp
      pick_ship_placement_size_2_for_human(pick_again)
    end
  end

  def pick_ship_placement_size_3_for_human(no_overlap, pick)
    if no_overlap.include? pick.split(' ')
      return pick.split(' ')
    else
      puts "You entered an incorrect guess\n
      either your ship is placed off the board or\n
      you forgot to put a space in between your\n
      ship's coordinates or your ship is overlaping\n
      your other ship. Try Again."
      pick_again = gets.chomp
      pick_ship_placement_size_2_for_human(pick_again)
    end
  end

  def place_ship(ship_points)
    ship_points.each do |point|
      @rows.map do |row|
        if row.include? point
          row[row.index(point)] = 'x'
        end
      end
    end
  end
end
