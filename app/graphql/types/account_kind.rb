module Types
  class AccountKind < Types::BaseEnum
    #Account.kinds.keys.each { |k| value(k.upcase, value:k.to_sym) }
    #https://stackoverflow.com/questions/64575090/dealing-with-graphql-enum-values-in-business-code
    value 'CREDIT', value: 0
    value 'DEBIT', value: 1
  end
end
