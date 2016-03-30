class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @tasks = Task.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: json_payload }
      end

    # respond_with(@tasks)
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

    # def json_payload
    #   @tasks.map do |task|
    #     {
    #       "startDate" => task.starttime.strftime("%Y,%m,%d"),
    #       "endDate" => task.endtime.strftime("%Y,%m,%d"),
    #       "headline" => task.label,
    #       "text" => task.text,
    #       "asset" => {"media" => task.label}
    #     }
    #   end
    # end

    def json_payload
      {
    "timeline" =>
    {
        "headline"=>"Prestigio Task System Timeline",
        "type"=>"default",
        "text"=>"<p>Simple task tracking system</p>",
        "date"=> @tasks.map { |task|
          {
            "startDate" => task.starttime.strftime("%Y,%m,%d,%H,%M"),
            "endDate" => task.endtime.strftime("%Y,%m,%d,%H,%M"),
            "headline" => task.assignee_from_id_to_name + '  (' + task.label + ')',
            "text" => task.text
          }
        },

        "era"=> [
            {
                "startDate"=>"2016,01,01",
                "endDate"=>"2017,01,01"
            }

        ]
    }
}
    end

end
