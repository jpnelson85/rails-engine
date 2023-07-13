class MerchantSerializer
  include JSONAPI::ObjectSerializer
  attributes :name

  has_many :items
end