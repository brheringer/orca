require "rails_helper"

RSpec.describe Types::QueryType do

  describe "accounts" do
    let!(:accounts) { [create(:account), create(:other_expenses)] } #let! não é lazy; let é lazy

    let(:query) do
      %(query {
        accounts {
          structure
          name
          kind
          username
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query,
        context: {current_user:'admin'})
        .as_json
    end

    it "should return all accounts" do
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result.dig("data", "accounts")).to match_array(
        accounts.map { |a| { "structure" => a.structure, "name" => a.name, "kind" => a.kind, "username" => a.username } }
      )
    end
    #nota: dig navega na hash; como retorno é {data:{accounts:{...}}}, então já sabe
    #nota: map deve ser igual react (pra cada elemento no array...)
  end

  describe "entries" do
    let!(:entries) { [create(:entry), create(:entry_gas)] }

    let(:query) do
      %(query {
        entries {
          date
          expectedValue
          actualValue
          memo
          username
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query,
        context: {current_user:'admin'})
        .as_json
    end

    it "should return all entries" do
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result.dig("data", "entries")).to match_array(
        entries.map { |e| { 
          "date" => e.date.to_s, 
          "expectedValue" => e.expected_value, 
          "actualValue" => e.actual_value, 
          "memo" => e.memo,
          "username" => e.username
          }
        }
      )
    end
  end

  describe "search entries by date" do
    let!(:entry_in_september) { create(:in_september) }
    let!(:entry_in_october) { create(:in_october) }

    let(:query) do
      %(query($start: ISO8601Date, $end: ISO8601Date) {
        entries(start: $start, end: $end) {
          date
          expectedValue
          actualValue
          memo
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query, 
        variables: {start: '2021-09-01', end: '2021-09-30'},
        context: {current_user:'admin'})
        .as_json
    end

    it "should find one entry in september" do
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result["data"]["entries"].length).to eq 1
      expect(result["data"]["entries"][0]["date"]).to eq '2021-09-01'
      expect(result["data"]["entries"][0]["expectedValue"]).to eq 100.00
      expect(result["data"]["entries"][0]["actualValue"]).to eq 100.00
      expect(result["data"]["entries"][0]["memo"]).to eq 'gas'
    end
  end

  describe "entry" do
    let!(:entry) { create(:entry) }

    let(:query) do
      %(query($id: ID!) {
        entry(id: $id) {
          id
          date
          expectedValue
          memo
        }
      })
    end

    subject(:result) do #significa: o subject (objeto do teste) vai ser o resultado da query (json); sem isso, seria QueryType.new
      OrcaSchema.execute(query, 
        variables: {id: entry.id},
        context: {current_user:'admin'})
        .as_json
    end

    it "should find one entry with specifid id" do
      expect(result.has_key?('data')).to eq(true), result["errors"]
      expect(result["data"]["entry"]["id"]).to eq "1"
      #TODO
    end
  end

end

#TODO teste entry.clipped_memo - quary funciona, mas o teste precisa ser mudado, pq nao acha campo, pois nao eh da entidade
#TODO teste me (current user)