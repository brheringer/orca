module Mutations
    class DeleteEntryMutation < Mutations::BaseMutation
      argument :id, ID, required: true
  
      field :ok, Boolean, null: true
      field :errors, [String], null: false
  
      def resolve(id:)
        entry = Entry.find(id)
        #TODO maybe filter by user
        if entry.delete()
          { ok: true }
        else
          { errors: account.errors.full_messages }
        end
      end
      
    end
  end