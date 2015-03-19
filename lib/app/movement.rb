require 'forwardable'

class Movement
  extend Forwardable

  def_delegator :@robot, :direction
  def_delegator :@robot, :table

  attr_reader :robot

  def initialize(robot)
    @robot = robot
  end

  def message(value)
    p "you shall not pass to -> #{direction} #{value}"
  end

  def border_reached?
    case direction
    when 'NORTH'
      (robot.y + 1) > table.height && message(robot.y + 1)
    when 'EAST'
      (robot.x + 1) > table.width && message(robot.x + 1)
    when 'SOUTH'
      (robot.y - 1) < 0 && message(robot.y - 1)
    when 'WEST'
      (robot.x - 1) < 0 && message.call(robot.x - 1)
    end
  end
end