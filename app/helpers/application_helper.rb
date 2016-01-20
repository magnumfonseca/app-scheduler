module ApplicationHelper
  def table_head
    content_tag :thead, class: "gainsboro" do
      content_tag :tr do
        concat hours_label
        days_of_week.each do |day|
          concat days_of_week_label(day)
        end
      end.html_safe
    end.html_safe
  end


  def generate_hour_range
    hours = []
    hour_step = (1.to_f/24)
    date_init = DateTime.new.change({ hour: 6 })
    date_limit = DateTime.new.change({ hour: 23 })
    date_init.step(date_limit, hour_step).each do |date|
      hours << "#{sprintf '%02d', date.hour}:00"
    end
    hours
  end

  def days_of_week
    ['seg','ter','qua', 'qui', 'sex']
  end

  def room_unavailable(event)
    content_tag :td, class: "info unavailable" do
      concat user_name_for_event(event.user.name)
      concat remove_buttom(event)
    end.html_safe
  end

  private
  def user_name_for_event(username)
    content_tag :b do
      username
    end.html_safe
  end
  def remove_buttom(event)
    return unless event.created_by?(current_user)
    content_tag :a do
      content = "<span class='glyphicon glyphicon-remove pull-right text-red' data-url=#{event_path(event)}></span>"
      content.html_safe
    end.html_safe
  end
  def days_of_week_label(label)
    content_tag :th, label
  end

  def hours_label
    content_tag :th, "Horário"
  end
end
