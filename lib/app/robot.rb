require 'rspec'

class DirectionIsNotRecognized < StandardError; end

class Robot
  private
  attr_writer :x, :y, :direction, :table

  public
  attr_reader :x, :y, :direction, :table

  def initialize(x = 0, y = 0, direction = 'NORTH')
    @x, @y, @direction = x, y, direction
    @table ||= Table.new()
    puts 'Robot is Not on table; Comands ignored' if !on_table?
  end

  def move
    case direction
    when 'NORTH'
      self.y = self.y + 1
    when 'EAST'
      self.x = self.x + 1
    when 'SOUTH'
      self.y = self.y - 1
    when 'WEST'
      self.x = self.x - 1
    else
      fail DirectionIsNotRecognized.new
    end unless Movement.new(self).border_reached?
  end

  def rotate(turn)
    self.direction = Rotator.new(self).new_direction(turn)
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