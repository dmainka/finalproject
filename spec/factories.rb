FactoryGirl.define do

  factory :user do
    name     "Daniel Mainka"
    email    "dmainka@gmail.com"
    password "password"
    password_confirmation "password"
    admin = true
  end

end
