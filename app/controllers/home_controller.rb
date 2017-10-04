class HomeController < ApplicationController
before_action :authenticate_user!
  def index
    if user_signed_in?
      redirect_to account_posts_path
      flash[:success] = 'Welcome to the RAILS NEW!'
    end
  end
end
