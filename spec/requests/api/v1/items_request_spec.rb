require "rails_helper"

RSpec.describe "Items API" do
  describe "Items API" do
    it 'sends a list of items' do
      create_list(:item, 3)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body)
    end
  end
end