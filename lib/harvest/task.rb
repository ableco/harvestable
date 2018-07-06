module Harvest
  class Task < Base
    scope :active, -> { where(is_active: "true") }
  end
end
