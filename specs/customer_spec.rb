require('minitest/autorun')
require('minitest/rg')
require_relative('../customer')
require_relative('../drink')
require_relative('../food')

class TestCustomer < MiniTest::Test


  def setup
    cust_name = "Mary"
    cust_wallet = 100
    cust_age = 18
    second_cust_age = 17
    drunkeness = 0
    drunkeness_tipsy = 8
    barely_tipsy = 1
    drink_name = "Ben's Whisky"
    drink_price = 20
    drink_price2 = 120
    alcohol_level = 5
    name = "Burger"
    price = 5
    rejuvenation_level = 2
    name2 = "Wedges"
    price2 = 120
    @first_food = Food.new(name, price, rejuvenation_level)
    @another_food = Food.new(name2, price2, rejuvenation_level)
    @a_drink = Drink.new(drink_name, alcohol_level, drink_price)
    @another_drink = Drink.new(drink_name, alcohol_level, drink_price2)
    @customer = Customer.new(cust_name, cust_age, cust_wallet, drunkeness)
    @second_customer = Customer.new(cust_name, second_cust_age, cust_wallet, drunkeness)
    @tipsy_customer = Customer.new(cust_name, cust_age, cust_wallet, drunkeness_tipsy)
    @barely_tipsy_customer = Customer.new(cust_name, cust_age, cust_wallet, barely_tipsy)
  end


  def test_buy_drink__success
    @customer.buy_drink(@a_drink)
    actual1 = @customer.wallet()
    expected1 = 80

    actual2 = @customer.buy_drink(@a_drink)
    expected2 = true

    assert_equal(actual1, expected1)
    assert_equal(actual2, expected2)
  end


  def test_buy_drink__fail
    @customer.buy_drink(@another_drink)
    actual1 = @customer.wallet()
    expected1 = 100

    actual2 = @customer.buy_drink(@another_drink)
    expected2 = false

    assert_equal(actual1, expected1)
    assert_equal(actual2, expected2)
  end


  def test_down_drink
    @customer.buy_drink(@a_drink)

    actual = @customer.drunkeness
    expected = 5

    assert_equal(expected, actual)
  end


  def test_buy_food__success
    @customer.buy_food(@first_food)
    actual1 = @customer.wallet()
    expected1 = 95

    actual2 = @customer.buy_food(@first_food)
    expected2 = true

    assert_equal(actual1, expected1)
    assert_equal(actual2, expected2)
  end


  def test_buy_food__fail
    @customer.buy_food(@another_food)
    actual1 = @customer.wallet()
    expected1 = 100

    actual2 = @customer.buy_food(@another_food)
    expected2 = false

    assert_equal(actual1, expected1)
    assert_equal(actual2, expected2)
  end


  def test_down_food__has_effect
    @tipsy_customer.buy_food(@first_food)

    actual = @tipsy_customer.drunkeness
    expected = 6

    assert_equal(expected, actual)
  end


  def test_down_food__no_effect
    @customer.buy_food(@first_food)

    actual = @customer.drunkeness
    expected = 0

    assert_equal(expected, actual)
  end


  def test_down_food__no_noticeable_effect
    actual = @barely_tipsy_customer.drunkeness
    expected = 1

    @barely_tipsy_customer.buy_food(@first_food)

    actual2 = @barely_tipsy_customer.drunkeness
    expected2 = 0

    assert_equal(expected, actual)
    assert_equal(expected2, actual2)
  end


end
