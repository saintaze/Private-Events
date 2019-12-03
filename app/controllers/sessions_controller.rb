class SessionsController < ApplicationController
    
  def new
    
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      flash[:success] = "Welcome #{@user.name.capitalize}! Be part of awesome events."
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    if logged_in?
      forget current_user
      logout
    end
    redirect_to root_url
  end

end

