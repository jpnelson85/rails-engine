require "rails_helper"

RSpec.describe "Merchants API" do
  describe "Merchants API" do
    it "sends a list of merchants" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)
      merchants =
      create_list(:merchant, 3)

      get "/api/v1/merchants"

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(3)

      merchants[:data].each do |merchant|

        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(Integer)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
      end
    end
  
    it "sends a list of items for a merchant" do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get '/api/v1/merchant/#{merchant.item.id}/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, sybolize_names: true)

      expect(items[:data].count).to eq(3)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(Integer)

        expect(item).to have_key(:description)
        expect(item[:description]).to be_a(String)

        expect(item).to have_key(:name)
        expect(item[:name]).to be_a(String)

        expect(item).to have_key(:unit_price)
        expect(item[:unit_price]).to be_a(Float)

        expect(item).to have_key(:merchant_id)
        expect(item[:merchant_id]).to be_an(Integer)
      end
    end
  end
end


