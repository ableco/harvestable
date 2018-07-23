require "test_helper"

class HarvestableTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Harvestable::VERSION
  end
end
