# frozen_string_literal: true

# Base class for all application controllers
class ApplicationController < ActionController::Base

  protected

  def current_user
    @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end

  def authenticate
    redirect_to sessions_new_url if current_user.nil?
  end
end
