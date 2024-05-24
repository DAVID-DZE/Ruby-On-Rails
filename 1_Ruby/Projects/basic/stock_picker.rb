def stock_picker(prices)
  best_days = []
  max_profit = 0

  prices.each_with_index do |buy_price, buy_day|
    prices[buy_day+1..-1].each_with_index do |sell_price, sell_day|
      if sell_price - buy_price > max_profit
        max_profit = sell_price - buy_price
        best_days = [buy_day, sell_day + buy_day + 1]
      end
    end
  end
  best_days
end

p stock_picker([17,3,6,9,15,8,6,1,10])
