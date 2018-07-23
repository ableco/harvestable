module Harvestable
  class Project < Base
    belongs_to :client

    scope :active, -> { where(is_active: "true") }
  end
end
