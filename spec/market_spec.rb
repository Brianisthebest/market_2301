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

  describe 'market' do
    it 'exists' do
      expect(@market).to be_a(Market)
      expect(@market.name).to eq('South Pearl Street Farmers Market')
      expect(@market.vendors).to eq([])
    end

    it 'can add a vendor and list names' do
      @market.add_vendor(@vendor1)
      expect(@market.vendors).to eq([@vendor1])
      expect(@market.vendor_names).to eq(['Rocky Mountain Fresh'])
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
      expect(@market.vendor_names).to eq(['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
    end

    it 'can list vendors that sell an item' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    end

    it 'can list items in alphabetical order' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @vendor2.stock(@item3, 25)
      @vendor3.stock(@item1, 65)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expected = ['Banana Nice Cream', 'Peach', 'Peach-Raspberry Nice Cream', 'Tomato']
      expect(@market.sorted_item_list).to eq(expected)
    end

    it 'reports quantities of all items sold at market' do 
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item4, 50)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)

      expect(@market.total_inventory[@item1][:quantity]).to eq(35)
      expect(@market.total_inventory[@item1][:vendors]).to eq([@vendor1])
      expect(@market.total_inventory[@item2][:quantity]).to eq(7)
      expect(@market.total_inventory[@item2][:vendors]).to eq([@vendor1])
      expect(@market.total_inventory[@item4][:quantity]).to eq(50)
      expect(@market.total_inventory[@item4][:vendors]).to eq([@vendor2])
    end

    it 'can report overstock' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item1, 40)
      @vendor2.stock(@item3, 50)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
    
      expect(@market.overstocked_items).to eq([@item1])
    end

    it 'can sell items' do
      @vendor1.stock(@item1, 35)
      @vendor1.stock(@item2, 7)
      @vendor2.stock(@item1, 40)
      @vendor2.stock(@item3, 50)
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      
      expect(@market.sell(@item1, 200)).to eq(false)
      expect(@market.sell(@item1, 40)).to eq(true)
      expect(@vender1.stock(@item1)).to eq(0)
      require 'pry'; binding.pry
      expect(@vender2.stock(@item1)).to eq(35)
    end
  end
end
