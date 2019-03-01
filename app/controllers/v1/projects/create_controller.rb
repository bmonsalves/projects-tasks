class V1::Projects::CreateController < ApplicationController

  def create
    project_instance = ::Projects::Create.new
    make_response(project_instance.create(params: params))
  end
end
