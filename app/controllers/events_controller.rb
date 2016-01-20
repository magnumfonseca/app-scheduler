class EventsController < ApplicationController
  before_action :authenticate_user!
  respond_to :json

  def create
    event = current_user.events.build(event_params)
    if event.save
      render json: { :stauts => :ok, event: event, user_name: current_user.name}
    else
      render json: { errors: event.errors.full_messages }, status: 422
    end
  end

  def destroy
    event = Event.find(id)
    event.destroy
    render :json => { :status => :ok }
  end

  private
  def event_params
    params.require(:event).permit(:week, :day, :hour)
  end

  def id
    params[:id]
  end
end
