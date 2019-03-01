class Task < ApplicationRecord
  belongs_to :project
  belongs_to :parent_task, class_name: 'Task', optional: true
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_task_id', dependent: :nullify

  scope :days_subtasks, ->(task) do
    task.subtasks.pluck(:day)
  end

end
