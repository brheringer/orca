require "rails_helper"

RSpec.describe Types::MutationType do

  describe "delete entry" do
    let!(:entry) { create(:entry) } #let! não é lazy; let é lazy; usa factoy_bot

    let(:query) do
      %(mutation DeleteEntryMutation($id: ID!) {
        deleteEntry(id: $id) {
          ok
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query, 
          variables: {id:entry.id},
          context: {current_user:'admin'})
          .as_json
    end

    it "should delete the entry" do
      #puts result #uncomment to inspect object in prompt
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result['data']['deleteEntry']['ok']).to be true
      #TODO consultar e garantir que nao existe mais?
    end
  end

end
