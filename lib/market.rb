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

  def sorted_item_list
    sorted_items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amnt|
        sorted_items.push(item.name)
      end
    end
    sorted_items.sort.uniq
  end

  def total_inventory
    tot_inv = Hash.new { |h, k| h[k] = { quantity: 0, vendors: [] } }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        tot_inv[item][:quantity] += quantity
        tot_inv[item][:vendors] << vendor
      end
    end
    tot_inv
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, item_info|
      if vendors_that_sell(item).length > 1 && item_info[:quantity] > 50
        overstocked_items << item
      end
    end
    overstocked_items
  end

  def sell(item, quantity)
    return false if total_inventory[item][:quantity] < quantity
    vendors_selling = total_inventory[item][:vendors]
    vendors_selling.each do |vendor|
      stock = vendor.check_stock(item)
      if stock <= quantity
        quantity -= stock

      end
    end
  end
end
# can only sell items if in stock
# return false if not in stock
# return true if in stock
# then reduce the stock of vendors
# first vendor added before moving to next