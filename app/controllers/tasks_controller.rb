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
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  def data
   events = Task.all
   render :json => events.map {|event| {
              :id => event.id,
              :start_date => event.starttime.to_formatted_s(:db),
              :end_date => event.endtime.to_formatted_s(:db),
              :text => event.label
          }}

  end

  def db_action
     mode = params["!nativeeditor_status"]
     id = params["id"]
     start_date = params["starttime"]
     end_date = params["endtime"]
     text = params["label"]

     case mode
       when "inserted"
         event = Task.create :start_date => start_date,
                             :end_date => end_date,
                             :text => text,
                             :tasktype => 'test_tasktype',
                             :label => 'test_label'
         tid = event.id

       when "deleted"
         Task.find(id).destroy
         tid = id

       when "updated"
         event = Task.find(id)
         event.start_date = start_date
         event.end_date = end_date
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


  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:tasktype, :label, :text, :assignee, :starttime, :endtime)
    end

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
