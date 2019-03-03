module Harvestable
  class Client < Base
    # Scopes
    scope :active, -> { where(is_active: "true") }
  end
end
