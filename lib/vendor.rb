class Vendor
  attr_reader :name,
              :inventory
              
  attr_accessor :stock

  def initialize(name)
    @name = name
    @inventory = {}
    @stocks = 0
  end

  def check_stock(item)
    @inventory.fetch(item, 0)
  end

  def stock(item, amount)
    @stocks = amount
    @inventory[item] = check_stock(item) + amount
  end

  def potential_revenue
    potential_rev = 0.0
    @inventory.each do |items, count|
      potential_rev += items.price * count
    end
    potential_rev
  end
end