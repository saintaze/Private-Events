class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # login @user
      # remember @user
      flash[:success] = "Welcome to Event Room! Experience new opportunities."
      redirect_to root_url
    else 
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    

end
