class ApplicationController < ActionController::Base
  LIST_OF_ENTITIES = 24

  protect_from_forgery with: :exception

  before_action :set_global_search_variable

  protected

  def require_admin!
    return if current_user.admin?

    redirect_to root_path
  end

  def set_global_search_variable
    @search = User.ransack(params[:q])
  end

end
