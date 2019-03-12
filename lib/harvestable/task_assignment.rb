module Harvestable
  class TaskAssignment < Base
    # Custom Paths
    collection_path "projects/:project_id/task_assignments"
    resource_path "projects/:project_id/task_assignments/:id"

    # Associations
    belongs_to :project
    belongs_to :task

    # Callbacks
    after_initialize :set_project_id

    def set_project_id
      return if project.nil?

      self.project_id = project.id
    end
  end
end
