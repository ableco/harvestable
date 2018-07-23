module Harvestable
  class TimeEntry < Base
    attributes :project_id, :task_id, :spent_date

    belongs_to :client
    belongs_to :user
    belongs_to :project
    belongs_to :task
    belongs_to :user_assignment
    belongs_to :task_assignment

    validates :project_id, :task_id, :spent_date, presence: true
  end
end
