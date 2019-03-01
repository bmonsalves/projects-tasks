class Task < ApplicationRecord
  belongs_to :project
  belongs_to :parent_task, class_name: 'Task', optional: true
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_task_id', dependent: :nullify

  scope :days_subtasks, ->(task) do
    task.subtasks.pluck(:day)
  end

  def subtask_per_day
    per_day = Project::TOTAL_TASKS.to_f / project.workingdays_list.size.to_f
    list = subtasks.order(init_date: :desc)
                   .map{ |s| s[:init_date].wday }
                   .group_by{ |a| a }

    max_subtask_per_day = per_day.ceil

    list.each do |key, subtask |
      if subtask.size >= max_subtask_per_day
        return ImmutableStruct.new(:error)
                              .new(error: "no puede crear mas tareas para este dia")
      end
    end

  end

end
