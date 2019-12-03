class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]

  include EventsHelper

  def index
    @event_type = params[:type] || 'future'
    if @event_type  == 'future'
      @events = Event.future.order(date: :asc)
    elsif @event_type  == 'past'
      @events = Event.past.order(date: :desc)
    end
    event_pagination_nav(type: @event_type)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created! Smiles all the way around."
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def attend
    @event = Event.find_by(id: params[:attendance][:event])
    @user = User.find_by(id: params[:attendance][:attendee])
    @event.attendees << @user
    redirect_to event_url(params[:attendance][:event])
  end

  def unattend
    @event = Event.find_by(id: params[:attendance][:event])
    @user = User.find_by(id: params[:attendance][:attendee])
    @event.attendees.delete(@user)
    redirect_to event_url(params[:attendance][:event])
  end

  private 
    
  def event_params
    params.require(:event).permit(:title, :description, :location, :date)
  end
end
