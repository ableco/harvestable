require "test_helper"

class TaskAssignmentTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::TaskAssignment) do |stub|
      task_assignment_attributes = { id: 12345, project: {  id: 1, name: "Pet Store", code: "PS" }, task: { id: 1, name: "Research" } }
      stub.get("/task_assignments") { |env| [200, {}, { task_assignments: [task_assignment_attributes] }.to_json] }
      stub.get("/projects/1/task_assignments") { |env| [200, {}, { task_assignments: [task_assignment_attributes] }.to_json] }
      stub.get("/projects/1/task_assignments/12345") { |env| [200, {}, task_assignment_attributes.to_json] }
    end
  end

  def test_find_for_project
    task_assignment = Harvestable::TaskAssignment.find("12345", project_id: 1)

    assert_equal 12345, task_assignment.id
    assert_equal "Pet Store", task_assignment.project.name
    assert_equal "PS", task_assignment.project.code
    assert_equal "Research", task_assignment.task.name
  end

  def test_all_for_project
    task_assignments = Harvestable::TaskAssignment.where(project_id: 1)
    task_assignment = task_assignments.first

    assert_equal 12345, task_assignment.id
    assert_equal "Pet Store", task_assignment.project.name
    assert_equal "PS", task_assignment.project.code
    assert_equal "Research", task_assignment.task.name
  end

  def test_all
    task_assignments = Harvestable::TaskAssignment.all
    task_assignment = task_assignments.first

    assert_equal 12345, task_assignment.id
    assert_equal "Pet Store", task_assignment.project.name
    assert_equal "PS", task_assignment.project.code
    assert_equal "Research", task_assignment.task.name
  end
end
