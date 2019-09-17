FactoryGirl.define do
  factory :user do
    first_name 'Person'
    last_name 'Example'
    sequence(:email) {|i| "person#{i}@domain.com" }
    password 'password'
    cpf '048.135.027-68'
    phone '(11) 1234-1234'
    created_at Time.current
    updated_at Time.current
    birthdate  20.years.ago.beginning_of_day
    gender 'm'
  end
end
