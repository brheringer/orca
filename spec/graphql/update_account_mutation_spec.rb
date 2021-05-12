require "rails_helper"

RSpec.describe Types::MutationType do

  describe "update account" do
    let!(:account) { create(:account) } #let! não é lazy; let é lazy; usa factoy_bot

    let(:query) do
      %(mutation UpdateAccountMutation($id: ID!, $structure: String!, $name: String!, $kind: Int!) {
        updateAccount(id: $id, structure: $structure, name: $name, kind: $kind) {
          account {
            id
            structure
            name
            kind
          }
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query, 
          variables: {id:account.id, structure:'1.1', name:'account name', kind: 1},
          context: {current_user:'admin'})
          .as_json
    end

    it "should update the account" do
      #puts result #uncomment to inspect object in prompt
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result['data']['updateAccount']['account']['id']).to eq('1')
      expect(result['data']['updateAccount']['account']['structure']).to eq('1.1')
      expect(result['data']['updateAccount']['account']['name']).to eq('account name')
      expect(result['data']['updateAccount']['account']['kind']).to eq(1)
    end
  end

end
