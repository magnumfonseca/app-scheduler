FactoryGirl.define do
  factory :user do
    name "Teste"
    sequence :email do |n|
      "octocat#{n}@github.com"
    end
    password '1superpassword'
  end
end
