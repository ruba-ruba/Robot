class Rotator
  attr_accessor :robot

  def initialize(robot)
    @robot = robot
  end

  def new_direction(new_direction)
    self.public_send("step_#{new_direction.downcase}") if robot.on_table?
  end

  def current
    POSITIONS.index(robot.direction.upcase)
  end

  def step_right
    if (current + 1) >= POSITIONS.size
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