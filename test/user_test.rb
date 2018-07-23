require "test_helper"

class UserTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::User) do |stub|
      user1_attributes = { id: 1, first_name: "John", last_name: "Doe", email: "john@example.com", is_active: false }
      user2_attributes = { id: 2, first_name: "Guillermo", last_name: "Iguaran", email: "guille@example.com", is_active: true }
      stub.get("/users/1") { |env| [200, {}, user1_attributes.to_json] }
      stub.get("/users/me") { |env| [200, {}, user2_attributes.to_json] }
      stub.get("/users?is_active=true") { |env| [200, {}, { users: [user2_attributes] }.to_json] }
      stub.get("/users") { |env| [200, {}, { users: [user1_attributes, user2_attributes] }.to_json] }
    end
  end

  def test_find
    user = Harvestable::User.find("1")

    assert_equal 1, user.id
    assert_equal "John", user.first_name
    assert_equal "Doe", user.last_name
    assert_equal "john@example.com", user.email
  end

  def test_all
    users = Harvestable::User.all.to_a

    assert_equal 2, users.size
    assert_equal 1, users.first.id
    assert_equal "John", users.first.first_name
    assert_equal "Doe", users.first.last_name
    assert_equal 2, users.last.id
    assert_equal "john@example.com", users.first.email
    assert_equal "Guillermo", users.last.first_name
    assert_equal "Iguaran", users.last.last_name
    assert_equal "guille@example.com", users.last.email
  end

  def test_active
    users = Harvestable::User.active

    assert_equal 1, users.size
    assert_equal "Guillermo", users.first.first_name
    assert_equal "Iguaran", users.first.last_name
    assert_equal "guille@example.com", users.first.email
  end

  def test_me
    user = Harvestable::User.me

    assert_equal 2, user.id
    assert_equal "Guillermo", user.first_name
    assert_equal "Iguaran", user.last_name
    assert_equal "guille@example.com", user.email
  end
end
