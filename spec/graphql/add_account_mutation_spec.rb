require "rails_helper"

RSpec.describe Types::MutationType do

  describe "add account" do

    let(:query) do
      %(mutation AddAccountMutation($structure: String!, $name: String!, $kind: AccountKind!) {
        addAccount(structure: $structure, name: $name, kind: $kind) {
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
          variables: {structure:'1.1', name:'account name', kind: 'CREDIT'},
          context: {current_user:'admin'})
          .as_json
    end

    it "should create an account" do
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result['data']['addAccount']['account']['structure']).to eq('1.1')
      expect(result['data']['addAccount']['account']['name']).to eq('account name')
      expect(result['data']['addAccount']['account']['kind']).to eq(0)
    end
  end

end
