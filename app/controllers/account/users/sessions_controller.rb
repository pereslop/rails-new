class Account::Users::SessionsController < Devise::SessionsController
  def create
    @user = User.find_by!(email: params[:user][:email])

    sign_in @user
    redirect_to account_root_path
  end

end
