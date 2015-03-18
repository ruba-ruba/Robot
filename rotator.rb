class Rotator
  attr_accessor :robot, :direction

  def initialize(robot, direction)
    @robot, @direction = robot, direction
    self.rotate
  end

  def rotate
    robot.direction =
      case direction
      when 'LEFT'
        step_left
      when 'RIGHT'
        step_right
      end
  end

  def current
    Robot::POSITIONS.index(robot.direction)
  end

  def step_right
    if current >= Robot::POSITIONS.size
      Robot::POSITIONS[0]
    else
      Robot::POSITIONS[current + 1]
    end
  end

  def step_left
    if current == 0
      Robot::POSITIONS[-1]
    else
      Robot::POSITIONS[current - 1]
    end
  end
end