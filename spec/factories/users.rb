FactoryGirl.define do
  factory :user do |f|
    f.first_name "Alexey"
    f.last_name "Levashev"
    f.password "Alexey123"
    f.email "alex@gmail.com"
    f.role "CZ"
    f.admin true
    f.activated 0
  end
end
