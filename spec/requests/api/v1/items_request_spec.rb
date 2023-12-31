require 'rails_helper'

RSpec.describe 'Items API' do
  describe '/api/v1/items' do
    it 'sends a list of items' do
      merchant = create(:merchant)
      items = create_list(:item, 3, merchant_id: merchant.id)

      get '/api/v1/items'

      expect(response).to be_successful

      items_details = JSON.parse(response.body, symbolize_names: true)

      expect(items_details[:data].count).to eq(3)

      items_details[:data].each do |item|
        expect(item).to have_key(:attributes)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end
  end

  describe 'get api/v1/items/:id' do
    it 'can get one item by item id' do
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

  describe 'post /app/v1/items' do
    it 'can create a new item' do
      @merchant = create(:merchant)
      item_details = {
        name: 'Banana',
        description: 'yellow and fresh',
        unit_price: 4.99,
        merchant_id: @merchant.id
      }

      post '/api/v1/items', params: { item: item_details }

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq('Banana')
      expect(item[:data][:attributes][:description]).to eq('yellow and fresh')
      expect(item[:data][:attributes][:unit_price]).to eq(4.99)
      expect(item[:data][:attributes][:merchant_id]).to eq(@merchant.id)
    end
  end

  describe 'patch /api/v1/items/:id' do
    it 'can update an existing item' do
      @merchant = create(:merchant)
      @merchant2 = create(:merchant)
      @item = Item.create!(name: 'Banana', description: 'yellow and fresh', unit_price: 4.99, merchant_id: @merchant.id)

      item_details = {
        name: 'Updated Name',
        description: 'Updated Description',
        unit_price: 9.99,
        merchant_id: @merchant.id
      }

      patch "/api/v1/items/#{@item.id}", params: { item: item_details }

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data][:attributes][:name]).to eq('Updated Name')
      expect(item[:data][:attributes][:description]).to eq('Updated Description')
      expect(item[:data][:attributes][:unit_price]).to eq(9.99)
      expect(item[:data][:attributes][:merchant_id]).to eq(@merchant.id)
      expect(item[:data][:attributes][:name]).to_not eq('Banana')
      expect(item[:data][:attributes][:description]).to_not eq('yellow and fresh')
      expect(item[:data][:attributes][:unit_price]).to_not eq(4.99)
      expect(item[:data][:attributes][:merchant_id]).to_not eq(@merchant2.id)
    end
  end

  describe 'delete /api/v1/items/:id' do
    it 'can delete an existing item' do
      @merchant = create(:merchant)
      @item1 = create(:item, merchant_id: @merchant.id)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{@item1.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{ Item.find(@item1.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'get /api/v1/items/:id/merchant' do
    it 'can get the merchant for an item' do
      @merchant = create(:merchant)
      @item1 = create(:item, merchant_id: @merchant.id)

      get "/api/v1/items/#{@item1.id}/merchants"

      expect(response).to be_successful

      merchant_data = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_data[:data][:attributes][:name]).to eq(@merchant.name)
    end
  end

  describe 'get /api/v1/items/find' do 

  end
end
