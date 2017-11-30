class Drink

  attr_reader :name, :alcohol, :price

  def initialize(name, alcohol_level, price)
    @name = name
    @alcohol = alcohol_level
    @price = price
  end


end
