# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :statistique do
    date "2014-06-05"
    duree "2014-06-05 21:35:28"
    questions 1
    taux 1.5
    champ_verbes "MyString"
    champ_mots "MyString"
  end
end
