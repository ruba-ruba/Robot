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

  def place(args)
    x,y,direction = args
    direction ||= 'NORTH'
    self.x = x.to_i
    self.y = y.to_i
    self.direction = direction
    self
  end

  def move(*)
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

  %w(left right).each do |method|
    define_method(method) do |*|
      rotate(__callee__)
    end
  end

  def rotate(turn)
    self.direction = Rotator.new(self).new_direction(turn.to_s)
  end

  def report(*)
    if on_table?
      message = "#{x}, #{y}, #{direction}"
      puts message
      message
    end
  end

  def on_table?
    return false if x > table.width  || x < 0
    return false if y > table.height || y < 0
    true
  end
end