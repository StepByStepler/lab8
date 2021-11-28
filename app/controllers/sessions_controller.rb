# frozen_string_literal: true

# Main controller
class SessionsController < ApplicationController
  def new; end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user.nil?
      respond_to do |format|
        format.all { render html: 'Вы ввели неверный логин или пароль', status: :unauthorized }
      end
    else
      respond_to { |format| format.all { render html: '', status: :ok } }
      session[:current_user_id] = user.id
    end
  end

  def destroy
    @_current_user = session[:current_user_id] = nil
    redirect_to root_url
  end
end
