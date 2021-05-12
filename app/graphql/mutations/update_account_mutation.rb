module Mutations
    class UpdateAccountMutation < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :structure, String, required: true
      argument :name, String, required: true
      argument :kind, Types::AccountKind, required: true
  
      field :account, Types::AccountType, null: true
      field :errors, [String], null: false
  
      def resolve(id:, structure:, name:, kind:)
        #TODO maybe filter by user
        if id && id.to_i > 0
          result = update(id: id, structure: structure, name: name, kind: kind);
        else
          result = add(structure: structure, name: name, kind: kind);
        end
        result
      end

      def update(id:, structure:, name:, kind:)
        account = Account.find(id)
        if account.update(structure: structure, name: name, kind: kind)
          { account: account }
        else
          { errors: account.errors.full_messages }
        end
      end

      def add(structure:, name:, kind:)
        account = Account.new(
            structure: structure,
            name: name,
            kind: kind
        )
  
        if account.save
          { account: account }
        else
          { errors: account.errors.full_messages }
        end
      end
      
    end
end