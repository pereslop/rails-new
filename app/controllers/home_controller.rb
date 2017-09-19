class HomeController < ApplicationController
  def index
    if current_user.user?
      redirect_to root_path
    else
      redirect_to admin_users_path
    end
  end
end
