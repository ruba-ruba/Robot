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
  attr_reader :file
  attr_accessor :robot

  def initialize
    @file    = ARGV.first
    @robot ||= Robot.new
  end

  def read_commands
    puts 'type commands'
    ARGF.each do |line|
      next if line.strip.empty?
      break if line.strip.match(/exit/)
      run_commands(line)
    end
  end

  def run_commands(line)
    command, args = line.split
    self.send(command, args)
  end

  def method_missing(method, *args, &block)
    robot.public_send(method.downcase, args)
  rescue
    puts "Error: #{method} is not defined"
  end
end

Reader.new.read_commands
