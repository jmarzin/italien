# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password  '12345'
    password_confirmation '12345'

    trait   :jacques do
      email 'jacques.marzin@free.fr'
    end
    trait   :admin do
      email 'jmarzin@gmail.com'
      admin true
    end
    factory :jacques,    traits: [:jacques]
    factory :admin,      traits: [:admin]
  end
end
