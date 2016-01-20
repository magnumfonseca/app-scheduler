class SchedulerController < ApplicationController
  before_filter :authenticate_user!

  def index
    @current_week = Date.today.cweek
    events = Event.where(week: @current_week)
    @hash_events = build_hahs_events(events)
  end

  private
  def build_hahs_events(events)
    return {} if events.blank?
    hash = {}
    events.each do |event|
      (hash[event.day] ||= {}).store(event.hour, event)
    end
    hash
  end
end
