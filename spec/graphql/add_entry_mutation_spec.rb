require "rails_helper"

RSpec.describe Types::MutationType do
  let!(:account) { create(:account) }

  describe "add entry" do

    let(:query) do
      %(mutation AddEntryMutation(
        $date: ISO8601Date!, 
        $expectedValue: Float!, 
        $actualValue: Float!, 
        $memo: String,
        $accountId: ID!) {
        addEntry(date: $date, expectedValue: $expectedValue, actualValue: $actualValue, memo: $memo, accountId: $accountId) {
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
          variables: {date:"2020-09-01", expectedValue:100.00, actualValue:99.99, memo:"this is a memo", accountId:account.id},
          context: {current_user:'admin'})
          .as_json
    end

    it "creates an entry" do
      #puts result #uncomment to inspect object in prompt
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result['data']['addEntry']['entry']['id']).to eq('1')
      expect(result['data']['addEntry']['entry']['date']).to eq('2020-09-01')
      expect(result['data']['addEntry']['entry']['expectedValue']).to eq(100.00)
      expect(result['data']['addEntry']['entry']['actualValue']).to eq(99.99)
      expect(result['data']['addEntry']['entry']['account']['structure']).to eq('1')
      expect(result['data']['addEntry']['entry']['username']).to eq('admin')
    end
  end

end
