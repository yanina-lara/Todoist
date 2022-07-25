class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = TaskServices::FiltersTasks.new(1, 
              :deadline => DateTime.now + 7.days, 
              :status => "to_do", 
              :created_at => DateTime.now - 2.days).filter_tasks.order_deadline_level
  end

  def show_tasks_tag
    @tasks = Tag.find(params["tag_id"]).tasks.to_a.each{ |task| task.user_id == params["user_id"].to_i }
    render action: :index
  end
  
  def create
    @task = Task.new(task_params, user_id: current_user.id)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
