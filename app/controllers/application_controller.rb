class ApplicationController < ActionController::Base
  def current_user
    @current_user = User.find(params[:id])
  end
end
