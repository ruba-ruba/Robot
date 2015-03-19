require 'rspec'

class Robot
  attr_accessor :x, :y, :direction, :table

  def initialize(x = 0, y = 0, direction = 'NORTH')
    @x, @y, @direction = x, y, direction
    @table = Table.new()
    puts 'Robot is Not on table; Comands ignored' if !on_table?
  end

  def move
    Movement.new(self)
  end

  def rotate(turn)
    Rotator.new(self, turn)
  end

  def report
    "#{x}, #{y}, #{direction}" if on_table?
  end

  def on_table?
    return false if x >= table.width  || x < 0
    return false if y >= table.height || y < 0
    true
  end
end