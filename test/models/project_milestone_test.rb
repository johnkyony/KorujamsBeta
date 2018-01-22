require "test_helper"

describe ProjectMilestone do
  let(:project_milestone) { ProjectMilestone.new }

  it "must be valid" do
    value(project_milestone).must_be :valid?
  end
end
