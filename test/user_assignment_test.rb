require "test_helper"

class UserAssignmentTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::UserAssignment) do |stub|
      user_assignment_attributes = { id: 12345, project: {  id: 1, name: "Pet Store", code: "PS" }, user: { id: 1, name: "Guillermo Iguaran" } }
      stub.get("/user_assignments") { |env| [200, {}, { user_assignments: [user_assignment_attributes] }.to_json] }
      stub.get("/projects/1/user_assignments") { |env| [200, {}, { user_assignments: [user_assignment_attributes] }.to_json] }
      stub.get("/projects/1/user_assignments/12345") { |env| [200, {}, user_assignment_attributes.to_json] }
    end
  end

  def test_find_for_project
    user_assignment = Harvestable::UserAssignment.find("12345", project_id: 1)

    assert_equal 12345, user_assignment.id
    assert_equal "Pet Store", user_assignment.project.name
    assert_equal "PS", user_assignment.project.code
    assert_equal "Guillermo Iguaran", user_assignment.user.name
  end

  def test_all_for_project
    user_assignments = Harvestable::UserAssignment.all(project_id: 1)
    user_assignment = user_assignments.first

    assert_equal 12345, user_assignment.id
    assert_equal "Pet Store", user_assignment.project.name
    assert_equal "PS", user_assignment.project.code
    assert_equal "Guillermo Iguaran", user_assignment.user.name
  end

  def test_all
    user_assignments = Harvestable::UserAssignment.all
    user_assignment = user_assignments.first

    assert_equal 12345, user_assignment.id
    assert_equal "Pet Store", user_assignment.project.name
    assert_equal "PS", user_assignment.project.code
    assert_equal "Guillermo Iguaran", user_assignment.user.name
  end
end
