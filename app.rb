require 'pry'
require 'forwardable'

require_relative 'rotator'
require_relative 'robot'
require_relative 'movement'

POSITIONS = %w(NORTH EAST SOUTH WEST)

class DirectionIsNotRecognized < StandardError; end


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
    run_commands if file
  end

  def run_commands
    File.readlines(file).each do |line|
      line = line.strip
      if line.match(/PLACE/)
        x,y,d = line.gsub(/PLACE/, '').strip.split(',')
        @robot = Robot.new(x.to_i, y.to_i, d)
      elsif matchdata = (line.match(/LEFT/) || line.match(/RIGHT/))
        robot.rotate(matchdata[0]) if robot
      elsif line.match(/MOVE/)
        robot.move
      elsif line.match(/REPORT/)
        puts robot.report
      end
    end
  end
end

Reader.new.execute
