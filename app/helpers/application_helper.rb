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

  private
  def days_of_week_label(label)
    content_tag :th, label
  end

  def hours_label
    content_tag :th, "Horário"
  end
end
