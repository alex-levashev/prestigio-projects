class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tasks = Task.all
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = current_user.tasks.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    if(@task.valid?)
        @task.save!
        flash[:notice] = "New task created!"
        redirect_to tasks_path
    else
        respond_with(@task)
    end
    # respond_with(@task)
  end

  def update
    @task.update(task_params)
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  def data
     events = Task.all


  events_json = events.map {|event|
  if event.done
    color = 'green'
  else
    color = 'red'
  end
              {
              :id => event.id,
              :start_date => event.starttime.to_formatted_s(:db),
              :end_date => (event.endtime+1.day).to_formatted_s(:db),
              :text => event.assignee_from_id_to_name + " - " + event.tasktype + " - " + event.label,
              :color => color
              }

            }
    render :json => events_json

  end

  def db_action
     mode = params["!nativeeditor_status"]
     id = params["id"]
     start_date = params["start_date"]
     end_date = params["end_date"]
     text = params["label"]

     case mode
       when "inserted"
         event = Task.create :starttime => start_date,
                             :endtime => end_date,
                             :text => text

         tid = event.id
       when "deleted"
         Task.find(id).destroy
         tid = id

       when "updated"
         event = Task.find(id)
         event.starttime = start_date
         event.endtime = end_date
         event.text = text
         event.save
         tid = id
     end

     render :json => {
                :type => mode,
                :sid => id,
                :tid => tid,
            }
   end

   def redmine_update
     Redminer.redmine_projects
     flash[:notice] = "Project list was updated!"
     redirect_to tasks_path
   end


  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:tasktype, :label, :text, :assignee, :starttime, :endtime, :done)
    end


end
