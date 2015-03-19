class Rotator
  attr_accessor :robot, :direction

  def initialize(robot, direction)
    @robot, @direction = robot, direction
    self.rotate if robot.on_table?
  end

  def rotate
    robot.direction = self.public_send("step_#{direction.downcase}")
  end

  def current
    POSITIONS.index(robot.direction)
  end

  def step_right
    if current >= POSITIONS.size
      POSITIONS[0]
    else
      POSITIONS[current + 1]
    end
  end

  def step_left
    if current == 0
      POSITIONS[-1]
    else
      POSITIONS[current - 1]
    end
  end
end