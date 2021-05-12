class Entry < ApplicationRecord
    belongs_to :account
    validates :date, presence: true
    validates :expected_value, presence: true
    validates :actual_value, presence: true
    validates :account, presence: true
    validates :memo, presence: false
    validates :username, presence: true
end
