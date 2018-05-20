class GameBoard
  attr_reader :rows,
              :spaces

  def initialize
    @rows = [['a1', 'a2', 'a3', 'a4'],\
             ['b1', 'b2', 'b3', 'b4'],\
             ['c1', 'c2', 'c3', 'c4'],\
             ['d1', 'd2', 'd3', 'd4']]
  end

  def change_space_objects(ship_points)
    ship_points.each do |point|
      @rows.map do |row|
        if row.include? point
          row[row.index(point)] = 'x'
        end 
      end
    end
  end
end
