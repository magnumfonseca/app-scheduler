FactoryGirl.define do
  factory :event do
    week Date.today.cweek
    day "sex"
    hour 23
    user nil
  end
end
