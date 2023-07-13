require "rails_helper"

RSpec.describe "Merchants API" do
  describe "api/v1/merchants" do
    it "sends a list of merchants" do
      merchant = create(:merchant)
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
  end
  
  describe "get api/v1/merchants/:id" do
    it "sends one merchant by merchant id" do
      merchant = create(:merchant)

      get '/api/v1/merchant/#{merchant.id}'

      expect(response).to be_successful

      items = JSON.parse(response.body, sybolize_names: true)

        expect(response).to be_successful
      
        expect(merchant[:data]).to have_key(:id)
        expect(merchant[:data][:id]).to be_a(String)
        expect(merchant[:data][:id].to_i).to eq(merchant.id)
      
        expect(merchant[:data][:attributes]).to have_key(:name)
        expect(merchant[:data][:attributes][:name]).to be_an(String)
    end
  end

  describe "get api/v1/merchants/:id/items" do
    it "can get all of a specific merchant's items" do
      merchant = create(:merchant)
      items = create_list(:item, 4, merchant_id: merchant.id)
        
      get "/api/v1/merchants/#{merchant.id}/items"
        
      expect(response).to be_successful
        
      merchant_items = JSON.parse(response.body, symbolize_names: true)
        
      expect(merchant_items[:data].count).to eq(4)
  
      merchant_items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item[:id].to_i).to be_an(Integer)
          
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_an(String)
  
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_an(String)
  
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_an(Float)
      end
    end
  end
end


