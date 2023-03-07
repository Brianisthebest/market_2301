class Vendor
  attr_reader :name,
              :inventory,
              :stock

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def check_stock(item)
    @inventory.fetch(item, 0)
  end

  def stock(item, amount)
    @inventory[item] = check_stock(item) + amount
  end
end
