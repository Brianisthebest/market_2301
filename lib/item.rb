class Item
  attr_reader :name 
  attr_accessor :price
  def initialize(item_details)
    @name = item_details[:name]
    @price = set_price(item_details[:price])
  end

  def set_price(price)
    price.delete('$').to_f
  end
end
