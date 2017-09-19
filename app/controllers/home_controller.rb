class HomeController < ApplicationController
  def admin
    if current_user.status == 'admin'
      render :admin
    else
      redirect_to root_path
    end
  end
end
