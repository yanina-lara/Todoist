class TasksNotCompletedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    tomorrow = DateTime.now + 1.days
    tasks = Task.where(deadline: tomorrow)
    tasks.each do |task|
      notify_deadline(task)
    end
  end
end
