FactoryBot.define do
  factory :entry do
    date { "2021-01-01" }
    expected_value { "9.99" }
    actual_value { "9.99" }
    memo { "some memo" }
    account { build(:account) }
    username { "admin" }
  end

  factory :entry_gas, class: "Entry" do
    date { "2021-01-31" }
    expected_value { "100.00" }
    actual_value { "100.00" }
    memo { "gas" }
    account { build(:other_expenses) }
    username { "admin" }

    factory :in_september, class: "Entry" do
      date { "2021-09-01" }
    end

    factory :in_october, class: "Entry" do
      date { "2021-10-01" }
    end
  end

end
