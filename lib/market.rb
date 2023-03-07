class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    ven_names = []
    @vendors.each do |vendor|
    ven_names.push(vendor.name)
    end
    ven_names
  end

  def vendors_that_sell(item)
    vendors_with = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
        vendors_with << vendor
      end
    end
    vendors_with
  end
end
