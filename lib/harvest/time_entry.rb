module Harvest
  class TimeEntry < Base
    belongs_to :client
    belongs_to :user
    belongs_to :project
    belongs_to :task
    belongs_to :user_assignment
    belongs_to :task_assignment
  end
end
