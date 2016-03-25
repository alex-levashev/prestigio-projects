class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :check_user_availability, only: [:create]

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
    @task.save
    # respond_with(@task)
    redirect_to tasks_path
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end
  
  def check_user_availability
    actual_task = Task.find(params)
    id = actual_task.assignee
    timerange = (actual_task.starttime..actual_task.endtime)
    User.find_by_id(id).alltasks.each do |task|
      timerange_user = task.starttime..task.endtime
      return true if timerange_user.include?(timerange)
    end
    return false
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:tasktype, :label, :text, :assignee, :starttime, :endtime)
    end
    
end
