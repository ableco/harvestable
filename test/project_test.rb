require "test_helper"

class ProjectTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::Project) do |stub|
      project_attributes = { id: 12345, code: "PS", name: "Pet Store", is_active: true, starts_on: "2017-06-01", client: {id: 12345, name: "Able", currency: "USD"} }
      stub.get("/projects/12345") { |env| [200, {}, project_attributes.to_json] }
      stub.get("/projects") { |env| [200, {}, { projects: [project_attributes] }.to_json] }
    end
  end

  def test_find
    project = Harvestable::Project.find("12345")

    assert_equal 12345, project.id
    assert_equal "Pet Store", project.name
    assert_equal "2017-06-01", project.starts_on
    assert_equal 12345, project.client.id
    assert_equal "Able", project.client.name
  end

  def test_all
    projects = Harvestable::Project.all.to_a
    project = projects.first

    assert_equal 1, projects.size
    assert_equal 12345, project.id
    assert_equal "Pet Store", project.name
    assert_equal "2017-06-01", project.starts_on
    assert_equal 12345, project.client.id
    assert_equal "Able", project.client.name
  end
end
