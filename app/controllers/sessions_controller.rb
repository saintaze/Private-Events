class SessionsController < ApplicationController
    
  def new
    
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # if @user.admin?
      #   message = "Welcome #{@user.username.capitalize}! So you are looking to delete some secrets?"
      # else
      #   message = "Welcome #{@user.username}! It\'s great that you wish to read/share scerets."
      # end
      flash[:success] = "Welcome #{@user.name.capitalize}! Be part of awesome events."
      redirect_to root_url
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

