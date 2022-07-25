class ApplicationController < ActionController::Base

  helper_method :current_user
  before_action :require_login, :correct_user

  def require_login
    redirect_to not_logged if current_user.nil?
  end

  def current_user
    @current_user ||= User.find(params["user_id"])
  end

  def correct_user
    unless current_user == User.find(params["user_id"])
      redirect_to unauthorized
    end
  end
  
end
