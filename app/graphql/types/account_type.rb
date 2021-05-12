module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :structure, String, null: false
    field :name, String, null: false
    field :username, String, null: false
    field :kind, Int, null: false
  end
end
