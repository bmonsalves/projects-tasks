# -*- encoding: utf-8 -*-
require 'rails_helper'

describe "create task" do

  before do
    @project = Project.create(name: "project", workingdays: "[1,2,3,4,5]")
    @task = Task.create(project_id: @project.id,
                        title: "tarea 1",
                        description: "nueva tarea",
                        init_date:"2019-03-01",
                        finish_date: "2019-03-07")
  end

  describe 'create' do
    context 'successfully' do
      it 'new task' do

        params = ActionController::Parameters.new({
            "project_id": @project.id,
            "task":{
                "project_id": @project.id,
                "title": "tarea 1",
                "description":"nueva tarea",
                "parent_task_id": nil,
                "init_date":"2019-03-02",
                "finish_date": "2019-03-07"
            }
        })


        task_instance = Tasks::Create.new project: @project
        task = task_instance.create(task_params: params)
        expect(task.respond_to?(:id)).to eq(true)
      end

      it 'new subtask' do

        params = ActionController::Parameters.new({
            "project_id": @project.id,
            "task":{
                "project_id": @project.id,
                "title": "subtask 1",
                "description":"nueva subtask",
                "parent_task_id": @task.id,
                "init_date":"2019-03-01",
                "finish_date": "2019-03-07"
            }
        })

        task_instance = Tasks::Create.new project: @project
        task = task_instance.create(task_params: params)
        expect(task.respond_to?(:id)).to eq(true)
      end
    end
  end
end
