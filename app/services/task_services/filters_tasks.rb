module TaskServices
  class FiltersTasks

    KEY_LIST = %i[deadline created_at tag level status].freeze

    def initialize(user, args = {})
      @user = user
      @args = args
    end

    def filter_tasks
      results = Task.where(user_id: user)
      return results if args.blank?
      args.each do |key, value|
        results = results.public_send("filter_#{key}", value) if KEY_LIST.include?(key)
      end
      results
    end

    private

    attr_accessor :user, :args

  end
end
