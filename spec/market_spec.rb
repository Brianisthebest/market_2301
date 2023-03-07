require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before(:each) do
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end
end
