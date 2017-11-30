require('minitest/autorun')
require('minitest/rg')
require_relative('../pub')
require_relative('../drink')
require_relative('../customer')
require_relative('../food')

class TestPub < MiniTest::Test

  def setup
    pub_name = "Bellie's"
    till = 1000
    limit = 30
    first_drink = Drink.new("Blue Myst", 5, 20)
    @second_drink = Drink.new("Terry's Orange", 5, 20)
    third_drink = Drink.new("Silver Vodka", 5, 20)
    @fourth_drink = Drink.new("Gin", 5, 20)
    drinks = [first_drink, @second_drink, third_drink]
    cust_name = "Mary"
    cust_age = 18
    under_age = 17
    cust_wallet = 20
    small_wallet = 19
    drunkeness = 29
    stone_cold_sober = 0
    too_drunk = 30
    food_name = "Burger"
    food_price = 20
    rejuvenation_level = 2
    food_name2 = "Wedges"
    @food_first = Food.new(food_name, food_price, rejuvenation_level)
    food_second = Food.new(food_name2, food_price, rejuvenation_level)
    @food_third = Food.new("Cheese", food_price, rejuvenation_level)
    foods = [@food_first, food_second]
    food_and_drink = [foods, drinks]
    @the_perfect_customer = Customer.new(cust_name, cust_age, cust_wallet, drunkeness)
    @skint_customer = Customer.new(cust_name, cust_age, small_wallet, drunkeness)
    @under_age_customer = Customer.new(cust_name, under_age, cust_wallet, drunkeness)
    @drunk_customer = Customer.new(cust_name, cust_age, cust_wallet, too_drunk)
    @sober_customer = Customer.new(cust_name, cust_age, cust_wallet, stone_cold_sober)
    @the_pub = Pub.new(pub_name, till, limit, food_and_drink)
    @test_empty_pub = Pub.new(pub_name, till, limit)
    @test_half_empty_pub = Pub.new(pub_name, till, limit, [['sauce'],[]])
    @test_other_half_empty_pub = Pub.new(pub_name, till, limit, [[],[first_drink]])
  end

  def test_pub__with_starting_drinks
    actual = @the_pub.drinks().count()
    expected = 3
    assert_equal(expected, actual)
  end


  def test_pub__with_no_starting_food_and_drink
    actual1 = @test_empty_pub.drinks().count()
    expected1 = 0

    actual2 = @test_empty_pub.foods().count()
    expected2 = 0

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_pub__with_starting_food_no_drink
    actual1 = @test_half_empty_pub.drinks().count()
    expected1 = 0

    actual2 = @test_half_empty_pub.foods().count()
    expected2 = 1

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_pub__with_starting_drink_no_food
    actual1 = @test_other_half_empty_pub.drinks().count()
    expected1 = 1

    actual2 = @test_other_half_empty_pub.foods().count()
    expected2 = 0

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_sell_drink__success__pub_effected
    actual1 = @the_pub.sell_drink(@the_perfect_customer, @second_drink)
    expected1 = true

    actual2 = @the_pub.drinks.count
    expected2 = 2

    actual3 = @the_pub.till
    expected3 = 1020

    actual4 = @the_pub.drinks.include?(@the_pub.drinks)
    expected4 = false

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
    assert_equal(expected4, actual4)
  end


  def test_sell_drink__success__customer_effected
    actual1 = @the_pub.sell_drink(@the_perfect_customer, @second_drink)
    expected1 = true

    actual2 = @the_perfect_customer.wallet
    expected2 = 0

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_sell_drink__fail__pub_status
    actual1 = @the_pub.sell_drink(@skint_customer, @second_drink)
    expected1 = false

    actual2 = @the_pub.drinks.count
    expected2 = 3

    actual3 = @the_pub.till
    expected3 = 1000

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
  end


  def test_sell_drink__fail__customer_status
    actual1 = @the_pub.sell_drink(@skint_customer, @second_drink)
    expected1 = false

    actual2 = @skint_customer.wallet
    expected2 = 19

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_sell_drink__fail_no_drink_in_stock__pub_status
    actual1 = @the_pub.sell_drink(@the_perfect_customer, @fourth_drink)
    expected1 = false

    actual2 = @the_pub.drinks.count
    expected2 = 3

    actual3 = @the_pub.till
    expected3 = 1000

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
  end


  def test_sell_drink__fail_no_drink_in_stock__customer_status
    actual1 = @the_pub.sell_drink(@the_perfect_customer, @fourth_drink)
    expected1 = false

    actual2 = @the_perfect_customer.wallet
    expected2 = 20

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end


  def test_check_legal_age__true
    actual = @the_pub.sell_drink(@the_perfect_customer, @second_drink)
    expected = true

    assert_equal(expected, actual)
  end


  def test_check_legal_age__false
    actual = @the_pub.sell_drink(@under_age_customer, @second_drink)
    expected = false

    assert_equal(expected, actual)
  end


  def test_drink_sale_allowed
    actual = @the_pub.sell_drink(@the_perfect_customer, @second_drink)
    expected = true

    assert_equal(expected, actual)
  end


  def test_drink_sale_allowed
    actual = @the_pub.sell_drink(@drunk_customer, @second_drink)
    expected = false

    assert_equal(expected, actual)
  end


  def test_sell_food__success__pub_effected
    actual1 = @the_pub.sell_food(@the_perfect_customer, @food_first)
    expected1 = true

    actual2 = @the_pub.foods().count()
    expected2 = 1

    actual3 = @the_pub.till
    expected3 = 1020

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
  end


  def test_sell_food__success__customer_effected
    actual1 = @the_pub.sell_food(@the_perfect_customer, @food_first)
    expected1 = true

    actual2 = @the_perfect_customer.wallet
    expected2 = 0

    actual3 = @the_perfect_customer.drunkeness
    expected3 = 27

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
  end


  def test_sell_food__fail__pub_status
    actual1 = @the_pub.sell_food(@skint_customer, @food_first)
    expected1 = false

    actual2 = @the_pub.foods.count
    expected2 = 2

    actual3 = @the_pub.till
    expected3 = 1000

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
    assert_equal(expected3, actual3)
  end


  def test_sell_food__fail__customer_status
    actual1 = @the_pub.sell_food(@skint_customer, @food_first)
    expected1 = false

    actual2 = @skint_customer.wallet
    expected2 = 19

    actual3 = @skint_customer.drunkeness
    expected3 = 29

    assert_equal(expected1, actual1)
    assert_equal(expected2, actual2)
  end



    def test_sell_food__fail__food_not_in_stock__pub_status
      actual1 = @the_pub.sell_food(@the_perfect_customer, @food_third)
      expected1 = false

      actual2 = @the_pub.foods.count
      expected2 = 2

      actual3 = @the_pub.till
      expected3 = 1000

      assert_equal(expected1, actual1)
      assert_equal(expected2, actual2)
      assert_equal(expected3, actual3)
    end


    def test_sell_food__fail__food_not_in_stock__customer_status
      actual1 = @the_pub.sell_food(@the_perfect_customer, @food_third)
      expected1 = false

      actual2 = @the_perfect_customer.wallet
      expected2 = 20

      actual3 = @the_perfect_customer.drunkeness
      expected3 = 29

      assert_equal(expected1, actual1)
      assert_equal(expected2, actual2)
    end


  def test_check_stock_details
    actual = @the_pub.stock
    expected = {"Blue Myst" => {:price => 20, :alcohol => 5},
                "Terry's Orange" => {:price => 20, :alcohol => 5},
                "Silver Vodka" => {:price => 20, :alcohol => 5}
                }

    assert_equal(expected, actual)
  end


  def test_check_stock_value
    actual = @the_pub.stock_value()
    expected = 60

    assert_equal(expected, actual)
  end

end
