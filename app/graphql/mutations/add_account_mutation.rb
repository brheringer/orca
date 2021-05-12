module Mutations
    class AddAccountMutation < Mutations::BaseMutation
      argument :structure, String, required: true
      argument :name, String, required: true
      argument :kind, Types::AccountKind, required: true
  
      field :account, Types::AccountType, null: true
      field :errors, [String], null: false
  
      def resolve(structure:, name:, kind:)
        account = Account.new(
            structure: structure,
            name: name,
            kind: kind,
            username: context[:current_user] #TODO DRY
        )
  
        if account.save
          { account: account }
        else
          { errors: account.errors.full_messages }
        end
      end

    end
  end