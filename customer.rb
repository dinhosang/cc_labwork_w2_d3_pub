class Customer

  attr_reader :wallet, :age, :drunkeness

  def initialize(name, age, wallet, drunkeness)
    @name = name
    @wallet = wallet
    @age = age
    @drunkeness = drunkeness
  end


  def buy_drink(random_drink_sold)
    price = random_drink_sold.price()

    if price <= @wallet
      @wallet -= price
      down_drink(random_drink_sold)
      return true
    end

    return false
  end


  def down_drink(drink)
    alcohol_value = drink.alcohol()
    @drunkeness += alcohol_value
  end


  def buy_food(random_food_sold)
    price = random_food_sold.price()

    if price <= @wallet
      @wallet -= price
      down_food(random_food_sold)
      return true
    end

    return false
  end


  def down_food(food)
    if @drunkeness > 0
      rejuvenation_level = food.rejuvenation
      @drunkeness -= rejuvenation_level
      if @drunkeness < 0
        @drunkeness = 0
      end
    end
  end


end
