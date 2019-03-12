module Harvestable
  class UserAssignment < Base
    # Custom Paths
    collection_path "projects/:project_id/user_assignments"
    resource_path "projects/:project_id/user_assignments/:id"

    # Associations
    belongs_to :user
    belongs_to :project

    # Callbacks
    after_initialize :set_project_id
    after_initialize :set_user_id

    def self.all
      raise NotImplementedError, "method has yet to be implemented"
    end

    private

    def set_project_id
      return if project.nil?

      self.project_id = project.id
    end

    def set_user_id
      return if user.nil?

      self.user_id = user.id
    end
  end
end
