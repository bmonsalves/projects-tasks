# README

### crear archivo config/application.yml

    development:
        DB_HOSTNAME: "localhost"
        DB_USERNAME: "DATABASE USER"
        DB_PASSWORD: "DATABASE PASS"
        DB_NAME: "DATABASE NAME"


crear proyecto

POST http://localhost:3000/v1/projects/create

    BODY
    {
        "project":{
        "name":"projecto 1",
		"description": "nuevo projecto",
		"workingdays": "[1,2,3,4]",
		"test_error": true
	}
}

crear task

POST http://localhost:3000/v1/tasks/create

si el atributo parent_task_id va null, creará una task,
si este atributo se incluye, creará una subtask para la tarea indicada

    BODY
    {
    	"project_id": <ID DEL PROYECTO>,
    	"task":{
    	  "project_id": <ID DEL PROYECTO>,
    	  "title": "subtarea 1",
          "description":"nueva subtarea",
          "parent_task_id": <ID DE LA TAREA>,
          "init_date":"2019-03-02",
          "finish_date": "2019-03-07"
    	}
    }