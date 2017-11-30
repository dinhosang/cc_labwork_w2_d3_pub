class Pub

  attr_reader :foods, :drinks, :till, :stock

  def initialize(name, till_value, limit, food_and_drink=[[],[]])
    @name = name
    @till = till_value
    @limit = limit
    @foods = food_and_drink[0] || []
    @drinks = food_and_drink[1] || []
    @stock = {}
    for drink in @drinks
      drink_name = drink.name
      drink_price = drink.price
      drink_alcohol = drink.alcohol
      @stock[drink_name] = {price: drink_price,
                            alcohol: drink_alcohol}
    end
  end


  def sell_drink(customer, drink)
    if @drinks.include?(drink)
      if legal_age?(customer)
        if under_limit?(customer)

          can_pay = customer.buy_drink(drink)

          if can_pay
            price = drink.price()
            @till += price
            @drinks.delete(drink)
            return true
          end
          return false
        end
        return false
      end
      return false
    end
    return false
  end


  def legal_age?(customer)
    if customer.age() >= 18
      return true
    end
    return false
  end


  def under_limit?(customer)
    if customer.drunkeness() < @limit
      return true
    end
    return false
  end


  def sell_food(customer, food)
    if foods.include?(food)
      can_pay = customer.buy_food(food)
      if can_pay
        price = food.price()
        @till += price
        @foods.delete(food)
        return true
      end
      return false
    end
    return false
  end


  def stock_value
    total_value = 0
    drink_names = @stock.keys
    for name in drink_names
      total_value += @stock[name][:price]
    end
    return total_value
  end


end
