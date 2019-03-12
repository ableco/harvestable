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
    after_initialize :set_task_id

    def self.all
      raise NotImplementedError, "method has yet to be implemented"
    end

    private

    def set_project_id
      return if project.nil?

      self.project_id = project.id
    end

    def set_task_id
      return if task.nil?

      self.task_id = task.id
    end
  end
end
