require "test_helper"

class RoleTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::Role) do |stub|
      role_attributes = { id: 1, name: "Developer", user_ids: [1] }

      stub.get("/roles/1") { |env| [200, {}, role_attributes.to_json] }
      stub.get("/roles") { |env| [200, {}, { roles: [role_attributes] }.to_json] }
    end

    stub_api_for(Harvestable::User) do |stub|
      user_attributes = { id: 1, first_name: "Guillermo", last_name: "Iguaran", email: "guille@example.com", is_active: true }

      stub.get("/users/1") { |env| [200, {}, user_attributes.to_json] }
    end
  end

  def test_find
    role = Harvestable::Role.find("1")

    assert_equal 1, role.id
    assert_equal "Developer", role.name
    assert_equal [1], role.user_ids
    assert_equal "Guillermo", role.users.first.first_name
    assert_equal "Iguaran", role.users.first.last_name
  end

  def test_all
    roles = Harvestable::Role.all.to_a
    role = roles.first

    assert_equal 1, roles.size
    assert_equal 1, role.id
    assert_equal "Developer", role.name
    assert_equal [1], role.user_ids
    assert_equal "Guillermo", role.users.first.first_name
    assert_equal "Iguaran", role.users.first.last_name
  end
end
