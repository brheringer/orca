module Mutations
    class UpdateEntryMutation < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :date, GraphQL::Types::ISO8601Date, required: true
      argument :expected_value, Float, required: true
      argument :actual_value, Float, required: true
      argument :memo, String, required: false
      argument :account_id, ID, required: true
  
      field :entry, Types::EntryType, null: true
      field :errors, [String], null: false
  
      def resolve(id:, date:, expected_value:, actual_value:, memo:, account_id:)
        #TODO maybe filter by user
        if id && id.to_i > 0
          result = update(id: id, date: date, expected_value: expected_value, actual_value: actual_value, memo: memo, account_id: account_id);
        else
          result = add(date: date, expected_value: expected_value, actual_value: actual_value, memo: memo, account_id: account_id);
        end
        result
      end

      def update(id:, date:, expected_value:, actual_value:, memo:, account_id:)
        entry = Entry.find(id)
        if entry.update(date: date, expected_value: expected_value, actual_value: actual_value, memo: memo, account_id: account_id)
          { entry: entry }
        else
          { errors: entry.errors.full_messages }
        end
      end

      def add(date:, expected_value:, actual_value:, memo:, account_id:)
        entry = Entry.new(
          date: date,
          expected_value: value,
          actual_value: value,
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