module Harvestable
  class Project < Base
    # Associations
    belongs_to :client
    has_many :user_assignments
    has_many :task_assignments

    # Scopes
    scope :active, -> { where(is_active: "true") }
  end
end
