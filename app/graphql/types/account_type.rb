module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :structure, String, null: false
    field :name, String, null: false
    field :username, String, null: false
    field :kind, AccountKind, null: false
  end
end
