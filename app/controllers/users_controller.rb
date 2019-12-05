class UsersController < ApplicationController

  before_action :logged_in_user, only: [:show, :index, :invite]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      remember @user
      flash[:success] = "Welcome to Event Room! Experience new opportunities."
      redirect_to events_path
    else 
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to events_url unless @user
  end

  def invite
    @users = User.all
    @event = current_user.events.find_by(id: params[:event_id])
    message = "Congrats! More people are coming to your event"
    if params[:invitees].nil?
      flash[:success] = "Oops! You have not selected any one to invite."
      return render 'index'
    end
    if @event
      params[:invitees].each do |invitee_id|
        @user = User.find_by(id: invitee_id)
        if @event.attendees.include?(@user)
          message = "Hmmm..! Some people are already invited!"
        else
          @event.attendees << @user 
        end
      end
      flash[:success] = message
      redirect_to event_path(@event)
    else
      flash[:success] = "Oops! You have not created any such event. Please provide a correct Event Id."
      render 'index'
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

   

end

