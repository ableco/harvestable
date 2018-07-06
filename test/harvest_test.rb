require "test_helper"

class HarvestTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Harvest::VERSION
  end
end
