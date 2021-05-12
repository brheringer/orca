module Types
  class MutationType < Types::BaseObject
    field :add_account, mutation: Mutations::AddAccountMutation
    field :update_account, mutation: Mutations::UpdateAccountMutation
    field :delete_account, mutation: Mutations::DeleteAccountMutation
    field :add_entry, mutation: Mutations::AddEntryMutation
    field :update_entry, mutation: Mutations::UpdateEntryMutation
    field :delete_entry, mutation: Mutations::DeleteEntryMutation
  end
end
