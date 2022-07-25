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

end
