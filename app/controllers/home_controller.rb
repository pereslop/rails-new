class HomeController < ApplicationController
  def index

  end

  def admin
    if current_user.admin?
      render :admin
    else
      redirect_to root_path
    end
  end
end
