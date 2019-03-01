module Tasks
  class Create
    include ::Concerns::Messages

    def initialize(project:)
      @project = project
    end

    attr_accessor :project, :task_params

    def create (task_params:)
      @task_params = whitelist_params task_params
      @workingdays = project.workingdays_list

      if @task_params[:parent_task_id].present?
        return split
      end

      create_task
    rescue StandardError => e
      error(message: e, code: 500)
    end

    private

    def split

      parent_task = project.tasks.find_by(id: task_params[:parent_task_id])

      init_date = validate_day(date: task_params[:init_date])
      return init_date if init_date.respond_to?(:error)

      finish_date = validate_day(date: task_params[:finish_date])
      return finish_date if finish_date.respond_to?(:error)

      days_tasks = Task.days_subtasks(parent_task)
      return error(message: 'total subtareas excedido') if days_tasks.size > Project::TOTAL_TASKS

      range_tasks = parent_task.subtask_per_day
      return range_tasks if range_tasks.respond_to?(:error)

      new_subtask = parent_task.subtasks.create(task_params)
      ImmutableStruct.new(:task)
                     .new(task: new_subtask)

    rescue StandardError => e
      error(message: e, code: 500)
    end

    def validate_day date:
      error(message: 'fecha no valida') unless date.present?

      day = DateTime.parse(date)
      error(message: 'el dia de inicio o termino debe ser un dia laboral') unless (day.wday - 1).in?(@workingdays)

      day
    end

    def create_task

      ImmutableStruct.new(:task)
                     .new(task: project.tasks.create(task_params))

    rescue StandardError => e
      error(message: e, code: 500)
    end

    def whitelist_params(params)
      params.require(:task)
          .permit(:id,
                  :title,
                  :description,
                  :project_id,
                  :parent_task_id,
                  :init_date,
                  :finish_date)
    end
  end
end