class Robot
  attr_accessor :x, :y, :direction, :table

  def initialize(x = 0, y = 0, direction = 'NORTH')
    @x, @y, @direction = x, y, direction
    @table = Table.new()
  end

  def move
    Movement.new(self, table)
  end


  def rotate(turn)
    Rotator.new(self, turn)
  end

  def report
    "#{x}, #{y}, #{direction}"
  end
end