require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")    
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack") 
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end

  it 'exists' do
    expect(@market).to be_a(Market)
    expect(@market.name).to eq('South Pearl Street Farmers Market')
    expect(@market.vendors).to eq([])
  end

  it 'can add a vendor' do
    @market.add_vendor(@vendor1)   
    expect(@market.vendor).to eq([@vendor1])
    @market.add_vendor(@vendor2) 
    @market.add_vendor(@vendor3) 
    expect(@market.vendor).to eq([@vendor1, @vendor2, @vendor3])
  end
end

# 1. Market Creation - including all attr_readers
# 2. Market #add_vendor
# 3. Market #vendor_names
# 4. Market #vendors_that_sell

# A Market is responsible for keeping track of Vendors. It should have a method called `vendor_names` that returns an array of all the Vendor's names.

# Additionally, the Market should have a method called `vendors_that_sell` that takes an argument of an item. It will return a list of Vendors that have that item in stock.

# Use TDD to create a `Market` class that responds to the following interaction pattern:
