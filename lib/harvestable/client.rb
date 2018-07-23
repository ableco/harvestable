module Harvestable
  class Client < Base
    scope :active, -> { where(is_active: "true") }
  end
end
