require 'pry'
require 'forwardable'

require_relative 'app/rotator'
require_relative 'app/robot'
require_relative 'app/movement'

POSITIONS = %w(NORTH EAST SOUTH WEST)

class Table
  attr_reader :height, :width
  def initialize(height = 5, width = 5)
    @height, @width = height, width
  end
end

class Reader
  extend Forwardable

  attr_reader :file
  attr_accessor :robot

  def_delegator :robot, :move, :rotate

  def initialize
    @file  = ARGV.first
    @robot = nil
  end

  def execute
    if file
      run_commands_from_file
    else
      read_commands
    end
  end

  def read_commands
    puts 'type commands'

    ARGF.each do |line|
      run_commands(line)
    end
  end

  def run_commands(line)
    binding.pry
  end

  def run_commands_from_file
    File.readlines(file).each do |line|
      line = line.strip
      if line.match(/PLACE/)
        init_robot(line)
      elsif matchdata = (line.match(/LEFT/) || line.match(/RIGHT/))
        robot.rotate(matchdata[0]) if robot
      elsif line.match(/MOVE/)
        robot.move
      elsif line.match(/REPORT/)
        puts robot.report
      end
    end
  end

  def init_robot(line)
    x,y,d = line.gsub(/PLACE/, '').strip.split(',')
    @robot = Robot.new(x.to_i, y.to_i, d)
  end
end

Reader.new.execute
