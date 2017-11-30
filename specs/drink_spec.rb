require('minitest/autorun')
require('minitest/rg')
require_relative('../drink')


class TestDrink < MiniTest::Test


  def setup
    drink_name = "Ben's Whisky"
    drink_price = 20
    alcohol_level = 5
    @a_drink = Drink.new(drink_name, alcohol_level, drink_price)
  end


end
