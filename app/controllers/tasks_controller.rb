class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = TaskServices::FiltersTasks.new(current_user.id, 
              :deadline_range => DateTime.now + 7.days, 
              :status => "to_do").filter_tasks.order_deadline_level
  end

  def show_tasks_tag
    @tasks = Tag.find(params["tag_id"]).tasks.to_a.each{ |task| task.user_id == current_user.id }
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

  private

  def task_params
    params.fetch(:task, {})
  end

end
