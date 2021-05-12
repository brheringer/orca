FactoryBot.define do
  factory :account do
    structure { "1" }
    name { "Revenues" }
    kind { 0 }
    username { "admin" }
  end

  factory :other_expenses, class: "Account" do
    structure { "2" }
    name { "Other Expenses" }
    kind { 1 }
    username { "admin" }
  end
end
