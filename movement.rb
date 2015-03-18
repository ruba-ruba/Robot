
class Movement
  extend Forwardable

  def_delegator :@robot, :direction

  attr_reader :robot, :table

  def initialize(robot, table)
    @robot = robot
    @table = table
    self.move
  end

  def move
    case direction
    when 'NORTH'
      robot.y += 1
    when 'EAST'
      robot.x += 1
    when 'SOUTH'
      robot.y -= 1
    when 'WEST'
      robot.x -= 1
    else
      fail DirectionIsNotRecognized.new
    end if !border_reached
  end

  def message(value)
    p "you shall not pass to -> #{direction} #{value}"
  end


  def border_reached
    case direction
    when 'NORTH'
      (robot.y + 1) > table.height && message(robot.y + 1)
    when 'EAST'
      (robot.x + 1) > table.height && message(robot.x + 1)
    when 'SOUTH'
      (robot.y - 1) < 0 && message(robot.y - 1)
    when 'WEST'
      (robot.x - 1) < 0 && message.call(robot.x - 1)
    end
  end
end