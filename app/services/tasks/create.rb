module Tasks
  class Create
    def initialize(project:)
      @project = project
    end

    attr_accessor :project, :task_params

    def create (task_params:)
      @task_params = whitelist_params task_params
      if @task_params[:parent_task_id].present?
        split
      else
        create_task
      end
    rescue StandardError => e
      e
    end

    private

    def split
      workingdays = eval(project.workingdays)
      parent_task = Task.find_by(id: task_params[:parent_task_id], project_id: project.id)

      days_tasks = Task.days_subtasks(parent_task)
      return {error: 'total subtareas excedido'} if days_tasks.size > Project::TOTAL_TASKS

      return {error: 'tarea en dia no laboral'} unless task_params[:day].in?(workingdays)

      if workingdays.size >= Project::TOTAL_TASKS
        return {error: 'dia ya tiene asignada una tarea'} unless task_params[:day].in?(days_tasks)
      end

      parent_task.subtasks.find_or_create_by(task_params)

    rescue StandardError => e
      e
    end

    def create_task

      Task.create(task_params)

    rescue StandardError => e
      e
    end

    def whitelist_params(params)
      params.require(:task)
          .permit(:id,
                  :title,
                  :description,
                  :project_id,
                  :day,
                  :parent_task_id)
    end


  end
end