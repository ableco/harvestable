require "test_helper"

class TaskTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::Task) do |stub|
      task_attributes = { id: 12345, name: "Setup CI for project", is_active: true }
      stub.get("/tasks/12345") { |env| [200, {}, task_attributes.to_json] }
      stub.get("/tasks") { |env| [200, {}, { tasks: [task_attributes] }.to_json] }
    end
  end

  def test_find
    task = Harvestable::Task.find("12345")

    assert_equal 12345, task.id
    assert_equal "Setup CI for project", task.name
    assert_equal true, task.is_active
  end

  def test_all
    tasks = Harvestable::Task.all.to_a
    task = tasks.first

    assert_equal 1, tasks.size
    assert_equal 12345, task.id
    assert_equal "Setup CI for project", task.name
    assert_equal true, task.is_active
  end
end
