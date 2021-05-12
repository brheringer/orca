class Account < ApplicationRecord
    #enum kind: [:credit, :debit]
    validates :name, presence: true
    validates :structure, presence: true
    validates :kind, presence: true
    validates :username, presence: true
end
