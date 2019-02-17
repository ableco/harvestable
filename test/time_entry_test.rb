require "test_helper"

class TimeEntryTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::TimeEntry) do |stub|
      user = { id: 1, name: "Guillermo Iguaran" }
      client = { id: 1, name: "Able" }
      project = { id: 1, name: "Pet Store" }
      task = { id: 1, name: "Graphic Design" }
      time_entry_attrs = { id: 123, user: user, client: client, project: project, task: task, hours: 2.0, started_time: "3:00pm", ended_time: "5:00pm" }
      stub.get("/time_entries") { |env| [200, {}, { time_entries: [time_entry_attrs] }.to_json] }
      stub.get("/time_entries/123") { |env| [200, {}, time_entry_attrs.to_json] }
      stub.post("/time_entries") { |env| [201, {}, time_entry_attrs.to_json] }
    end
  end

  def test_find
    time_entry = Harvestable::TimeEntry.find("123")

    assert_equal 123, time_entry.id
    assert_equal "Guillermo Iguaran", time_entry.user.name
    assert_equal "Able", time_entry.client.name
    assert_equal "Pet Store", time_entry.project.name
    assert_equal "Graphic Design", time_entry.task.name
    assert_equal "3:00pm", time_entry.started_time
    assert_equal "5:00pm", time_entry.ended_time
    assert_equal 2.0, time_entry.hours
  end

  def test_all
    time_entries = Harvestable::TimeEntry.all
    time_entry = time_entries.first

    assert_equal 123, time_entry.id
    assert_equal "Guillermo Iguaran", time_entry.user.name
    assert_equal "Able", time_entry.client.name
    assert_equal "Pet Store", time_entry.project.name
    assert_equal "Graphic Design", time_entry.task.name
    assert_equal "3:00pm", time_entry.started_time
    assert_equal "5:00pm", time_entry.ended_time
    assert_equal 2.0, time_entry.hours
  end

  def test_create_with_valid_attrs
    time_entry = Harvestable::TimeEntry.create(project_id: 1, task_id: 1, spent_date: "2017-03-21", hours: 2.0)

    assert_equal 123, time_entry.id
    assert_equal "Guillermo Iguaran", time_entry.user.name
    assert_equal "Able", time_entry.client.name
    assert_equal "Pet Store", time_entry.project.name
    assert_equal "Graphic Design", time_entry.task.name
    assert_equal 2.0, time_entry.hours
  end

  def test_create_with_invalid_attrs
    time_entry = Harvestable::TimeEntry.new(hours: 2.0)

    assert_raises Harvestable::ValidationError do
      time_entry.save
    end

    assert_equal "can't be blank", time_entry.errors[:spent_date].first
  end
end
