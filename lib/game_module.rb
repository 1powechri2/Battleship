def pick_ship_placement_size_2
ships_size_2 = [['a1', 'a2'], ['a2', 'a3'], ['a3', 'a4'],\
                ['b1', 'b2'], ['b2', 'b3'], ['b3', 'b4'],\
                ['c1', 'c2'], ['c2', 'c3'], ['c3', 'c4'],\
                ['d1', 'd2'], ['d2', 'd3'], ['d3', 'd4'],\
                ['a1', 'b1'], ['a2', 'b2'], ['a3', 'b3'],\
                ['a4', 'b4'], ['b1', 'c1'], ['b2', 'c2'],\
                ['b3', 'c3'], ['b4', 'c4'], ['c1', 'd1'],\
                ['c2', 'd2'], ['c3', 'd3'], ['c4', 'd4']]
  ships_size_2.sample
end


def pick_ship_placement_size_3(ship_size_2)
ships_size_3 = [['a1', 'a2', 'a3'], ['a2', 'a3', 'a4'],\
                ['b1', 'b2', 'b3'], ['b2', 'b3', 'b4'],\
                ['c1', 'c2', 'c3'], ['c2', 'c3', 'c4'],\
                ['d1', 'd2', 'd3'], ['d2', 'd3', 'd4'],\
                ['a1', 'b1', 'c1'], ['a2', 'b2', 'c2'],\
                ['a3', 'b3', 'c3'], ['a4', 'b4', 'c4'],\
                ['b1', 'c1', 'd1'], ['b2', 'c2', 'd2'],\
                ['b3', 'c3', 'd3'], ['b4', 'c4', 'd4']]
  ships_size_3.each do |ship|
    if ship.include? ship_size_2[0] || ship_size_2[1]
      ships_size_3.delete(ship)
    end
  end 
  ships_size_3.sample
end
