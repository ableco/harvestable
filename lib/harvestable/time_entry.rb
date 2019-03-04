module Harvestable
  class TimeEntry < Base
    # Attributes
    attributes :project_id, :task_id, :spent_date

    # Associations
    belongs_to :client
    belongs_to :user
    belongs_to :project
    belongs_to :task
    belongs_to :user_assignment
    belongs_to :task_assignment

    # Validations
    validates :project_id, presence: true, on: :create
    validates :task_id, presence: true, on: :create
    validates :spent_date, presence: true
  end
end
