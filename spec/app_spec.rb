require 'spec_helper'

RSpec.describe Robot do
  let(:robot) {Robot.new(1,1, "EAST")}

  it 'report' do
    expect(robot.report).to match('1, 1, EAST')
  end

  context 'move' do
    let(:robot) {Robot.new(1,1, "SOUTH")}

    subject { robot.move; robot.report}

    it 'to south' do
      should match('1, 0, SOUTH')
    end

    it 'to north' do
      allow(robot).to receive(:direction).and_return("NORTH")
      should match('1, 2, NORTH')
    end

    it 'to west' do
      allow(robot).to receive(:direction).and_return("WEST")
      should match('0, 1, WEST')
    end

    it 'to east' do
      allow(robot).to receive(:direction).and_return("EAST")
      should match('2, 1, EAST')
    end
  end

  context 'rotate' do
    let(:robot) {Robot.new(1,1, "SOUTH")}

    subject { robot.direction }

    it 'rotate left' do
      robot.rotate('LEFT')
      should eq 'EAST'
    end

    it 'rotate right' do
      robot.rotate('RIGHT')
      should eq 'WEST'
    end
  end

end