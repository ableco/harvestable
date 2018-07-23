require "test_helper"

class ClientTest < Minitest::Test
  include StubRequests

  def setup
    Harvestable.configure {}

    stub_api_for(Harvestable::Client) do |stub|
      client_attributes = { id: 12345, name: "Able", is_active: true, currency: "USD" }
      stub.get("/clients/12345") { |env| [200, {}, client_attributes.to_json] }
      stub.get("/clients") { |env| [200, {}, { clients: [client_attributes] }.to_json] }
    end
  end

  def test_find
    client = Harvestable::Client.find("12345")

    assert_equal 12345, client.id
    assert_equal "Able", client.name
    assert_equal "USD", client.currency
  end

  def test_all
    clients = Harvestable::Client.all.to_a

    assert_equal 1, clients.size
    assert_equal 12345, clients.first.id
    assert_equal "Able", clients.first.name
    assert_equal "USD", clients.first.currency
  end
end
