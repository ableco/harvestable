module Harvestable
  class Task < Base
    # Scopes
    scope :active, -> { where(is_active: "true") }
  end
end
