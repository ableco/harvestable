module Harvestable
  class UserAssignment < Base
    collection_path "projects/:project_id/user_assignments"
    resource_path "projects/:project_id/user_assignments/:id"

    belongs_to :user
    belongs_to :project

    def self.all(*params)
      if params.empty?
        get("/user_assignments")
      else
        super(*params)
      end
    end
  end
end
