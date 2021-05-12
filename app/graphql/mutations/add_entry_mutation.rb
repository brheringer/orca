module Mutations
    class AddEntryMutation < Mutations::BaseMutation
      argument :date, GraphQL::Types::ISO8601Date, required: true
      argument :expected_value, Float, required: true
      argument :actual_value, Float, required: true
      argument :memo, String, required: false
      argument :account_id, ID, required: true
  
      field :entry, Types::EntryType, null: true
      field :errors, [String], null: false
  
      def resolve(date:, expected_value:, actual_value:, memo:, account_id:)
        entry = Entry.new(
            date: date,
            expected_value: expected_value,
            actual_value: actual_value,
            memo: memo,
            account: Account.find(account_id),
            username: context[:current_user] #TODO DRY
        )
  
        if entry.save
          { entry: entry }
        else
          { errors: entry.errors.full_messages }
        end
      end

    end
  end