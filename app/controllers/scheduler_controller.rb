class SchedulerController < ApplicationController
  before_filter :authenticate_user!

  def index
    current_week = Date.today.cweek
    @events = Event.find_by_week(current_week)
  end
end
