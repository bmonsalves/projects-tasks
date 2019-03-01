class V1::Projects::CreateController < ApplicationController

  def create
    project_instance = ::Projects::Create.new
    render json: {project: project_instance.create(params: params)}
  end
end
