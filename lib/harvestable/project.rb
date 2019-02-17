module Harvestable
  class Project < Base
    belongs_to :client

    scope :active, -> { where(is_active: "true") }

    def user_assignments
      Harvestable::UserAssignment.where(project_id: self.id)
    end

    def task_assignments
      Harvestable::TaskAssignment.where(project_id: self.id)
    end
  end
end
