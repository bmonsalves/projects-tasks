class V1::Tasks::CreateController < ApplicationController

  def create
    task_instance = ::Tasks::Create.new project: project
    make_response(task_instance.create(task_params: params))
  end

  private

  def project
    @project ||= Project.find(params[:project_id])
  rescue StandardError => e
    e
  end

end
