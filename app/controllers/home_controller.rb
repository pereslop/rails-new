class HomeController < ApplicationController
  def index
    redirect_to account_posts_path if current_user
  end
end
