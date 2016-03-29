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
    byebug
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:tasktype, :label, :text, :assignee, :starttime, :endtime)
    end

end
