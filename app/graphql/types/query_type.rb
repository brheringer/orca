module Types
  class QueryType < Types::BaseObject
    field :accounts, [Types::AccountType], null: false, description: "Returns a list of accounts"
    def accounts
      query = Account.all
      query = query.where(username: context[:current_user]) #TODO DRY
      return query
    end

    field :entry, Types::EntryType, null: false do
      description "Find an entry by id"
      argument :id, ID, required: true
    end
    def entry(args)
      Entry.find(args[:id])
      #TODO filter by username
    end

    field :entries, [Types::EntryType], null: false do
      description "Returns a list of entries"
      argument :start, GraphQL::Types::ISO8601Date, required: false
      argument :end, GraphQL::Types::ISO8601Date, required: false
      #argument :account_id, Int, required: false
      #argument :memo, String, required: false
      #argument :lowerValue, Float, required: false
      #argument :higherValue, Float, required: false
    end
    def entries(args = {})
      #Entry.preload(:account)
      query = Entry.all
      query = query.where('date >= ?', args[:start]) if args[:start].present?
      query = query.where('date <= ?', args[:end]) if args[:end].present?
      query = query.where(username: context[:current_user]) #TODO DRY
      #query = query.where('memo like %?%', args[:memo]) if args[:memo].present?
      #query = query.where('value >= ?', args[:lowerValue]) if args[:lowerValue].present?
      #query = query.where('value <= ?', args[:higherValue]) if args[:higherValue].present?
      return query
    end

  end
end
