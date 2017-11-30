require('minitest/autorun')
require('minitest/rg')
require_relative('../food')

class TestFood < MiniTest::Test


  def setup
    name = "Burger"
    price = 5
    rejuvenation_level = 2
    @first_food = Food.new(name, price, rejuvenation_level)
  end


end
