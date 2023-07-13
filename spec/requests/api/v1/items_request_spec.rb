require "rails_helper"

RSpec.describe "Items API" do
  describe "/api/v1/items" do
    it 'sends a list of items' do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get '/api/v1/items'

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

    describe "get api/v1/items/:id" do
      it "can get one item by item id" do
        merchant = create(:merchant)
        item1 = create(:item, merchant_id: merchant.id)
        
        get "/api/v1/items/#{item1.id}"
        
        expect(response).to be_successful
  
        item = JSON.parse(response.body, symbolize_names: true)
        
        expect(item[:data]).to have_key(:id)
        expect(item[:data][:id]).to be_a(String)
        expect(item[:data][:id].to_i).to eq(item1.id)
  
        expect(item[:data][:attributes]).to have_key(:name)
        expect(item[:data][:attributes][:name]).to be_an(String)
  
        expect(item[:data][:attributes]).to have_key(:description)
        expect(item[:data][:attributes][:description]).to be_an(String)
  
        expect(item[:data][:attributes]).to have_key(:unit_price)
        expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      end
    end
  
    describe "post /app/v1/items" do
      it "can create a new item" do
        merchant = create(:merchant)
        item_details = {
          name: 'Banana',
          description: 'yellow and fresh',
          unit_price: 4.99,
          merchant_id: @merchant.id
        }
  
        post '/api/v1/items', params: { item: item_details}
  
        expect(response).to be_successful
  
        item = JSON.parse(response.body, symbolize_names: true)
  
        expect(item[:data][:attributes][:name]).to eq('New Item')
        expect(item[:data][:attributes][:description]).to eq('New Description')
        expect(item[:data][:attributes][:unit_price]).to eq(11.99)
        expect(item[:data][:attributes][:merchant_id]).to eq(merchant.id)
      end
    end
  end
  end
end