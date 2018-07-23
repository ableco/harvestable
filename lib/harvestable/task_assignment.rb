module Harvestable
  class TaskAssignment < Base
    collection_path "projects/:project_id/task_assignments"
    resource_path "projects/:project_id/task_assignments/:id"

    belongs_to :project
    belongs_to :task

    def self.all(*params)
      if params.empty?
        get("/task_assignments")
      else
        super(*params)
      end
    end
  end
end
