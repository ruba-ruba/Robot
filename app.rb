require 'pry'
require 'forwardable'

require_relative 'rotator'

FILENAME = 'test.txt' #ARGV.first

class DirectionIsNotRecognized < StandardError; end

class MovementIsNotRecogized < StandardError
  def initialize(turn)
    "tried to turn #{turn}"
  end
end

class Table
  # extend Forwardable

  attr_reader :height, :width, :robot

  # def_delegator :robot, :report

  def initialize(height = 5, width = 5)
    @height, @width = height, width
    # @robot = robot
  end
end

class Movement

  attr_reader :robot, :table

  def initialize(robot, table)
    @robot = robot
    @table = table
    self.move
  end

  def move
    case robot.direction
    when 'NORTH'
      robot.y += 1 unless border_reached
    when 'EAST'
      robot.x += 1 unless border_reached
    when 'SOUTH'
      robot.y -= 1 unless border_reached
    when 'WEST'
      robot.x -= 1 unless border_reached
    else
      fail DirectionIsNotrecognized.new
    end
  end

  def border_reached
    
  end
end

class Robot
  POSITIONS = %w(NORTH EAST SOUTH WEST)
  MOVEMENTS = %w(LEFT RIGHT)

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



class Reader
  extend Forwardable

  attr_reader :file
  attr_accessor :robot

  def_delegator :robot, :move, :rotate

  def initialize
    @file = FILENAME
    @robot = nil
  end

  def execute
    run_commands
  end

  def run_commands
    File.readlines(file).each do |line|
      line = line.strip
      if line.match(/PLACE/)
        x,y,d = line.gsub(/PLACE/, '').strip.split(',')
        @robot = Robot.new(x.to_i, y.to_i, d)
      elsif matchdata = (line.match(/LEFT/) || line.match(/RIGHT/))
        robot.rotate(matchdata[0])
      elsif line.match(/MOVE/)
        robot.move
      elsif line.match(/REPORT/)
        puts robot.report
      end
    end
  end
end


Reader.new.execute


# robot = Robot.new(0,0, 'North')

# puts robot.rotate('LEFT')
# puts robot.move

# puts robot.report
