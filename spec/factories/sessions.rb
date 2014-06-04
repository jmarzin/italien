# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    debut "2014-05-25 22:24:02"
    fin "2014-05-25 22:24:02"
    nb_questions 1
    nb_erreurs 1
  end
end
