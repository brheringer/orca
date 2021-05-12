require "rails_helper"

RSpec.describe Types::MutationType do
  let!(:entry) { create(:entry) }
  let!(:other_expenses) { create(:other_expenses) }

  describe "update entry" do

    let(:query) do
      %(mutation UpdateEntryMutation(
        $id: ID!,
        $date: ISO8601Date!, 
        $expectedValue: Float!, 
        $actualValue: Float!, 
        $memo: String,
        $accountId: ID!) {
        updateEntry(id: $id, date: $date, expectedValue: $expectedValue, actualValue: $actualValue, memo: $memo, accountId: $accountId) {
          entry {
            id
            date
            expectedValue
            actualValue
            memo
            username
            account {
              id
              structure
              name
            }
          }
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query, 
          variables: {id:entry.id, date:"2021-05-02", expectedValue:100.00, actualValue:99.99, memo:"changed memo", accountId:other_expenses.id},
          context: {current_user:'admin'})
          .as_json
    end

    it "should create an entry" do
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result['data']['updateEntry']['entry']['id'].to_i).to eq(entry.id)
      expect(result['data']['updateEntry']['entry']['date']).to eq('2021-05-02')
      expect(result['data']['updateEntry']['entry']['expectedValue']).to eq(100.00)
      expect(result['data']['updateEntry']['entry']['actualValue']).to eq(99.99)
      expect(result['data']['updateEntry']['entry']['memo']).to eq('changed memo')
      expect(result['data']['updateEntry']['entry']['account']['structure']).to eq('2')
      expect(result['data']['updateEntry']['entry']['username']).to eq('admin')
    end
  end

end
