require 'rails_helper'

#TODO refactor - this is testing the api from outside, with authentication
RSpec.describe GraphqlController, type: :request do

  describe 'API, Graphql, test with authentication' do
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

    it 'should get all accounts' do
        create(:account)
        json = execute_gql(query)
      
        expect(json.has_key?('data')).to be(true), json['message']
        expect(json['data'].has_key?('accounts')).to be(true), json['data']['errors']
        data = json['data']['accounts']

        expect(data.length).to be 1
    end
  end

  def execute_gql(gql)
    token = login()
    post '/graphql', 
      params: { query: gql },
      headers: { "Authorization" => "Bearer #{token}" }
    json = JSON.parse(response.body)
    json
  end

  def login #TODO refactor to somewhere reusable 
    post '/users', params: {username: 'admin', password: 'admin'}
    post '/login', params: {username: 'admin', password: 'admin'}
    json = JSON.parse(response.body)
    json['token']
  end
end