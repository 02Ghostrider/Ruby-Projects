#Stock Picker

def stock_picker(daily_prices)

	@diff = 0
	@buy_day = 0
	@sell_day = 0

	daily_prices[0..-2].each do |get|
		i = daily_prices.index(get)
		daily_prices[i..-1].each do |toss|
			j = daily_prices.index(toss)
			if (toss - get) > @diff
				@diff = toss - get
				@buy_day = daily_prices[0..-2].index(get) + 1
				@sell_day = daily_prices[1..-1].index(toss) + 2
				@buy = get
				@sell = toss
			end
		end
	end


end

puts "\n\nThe Magic Eight Ball says your stock prices for the next nine days will be:"
puts "\n$17 $3 $6 $9 $15 $8 $6 $1 $10"
prices = [17,3,6,9,15,8,6,1,10]
stock_picker(prices)
puts "\n\nThe best days to flip the stock for profit are to buy in " + @buy_day.to_s + " days at $" + @buy.to_s + ", "
puts "\nthen sell in " + @sell_day.to_s + " days at $" + @sell.to_s + ". Earnings will be $" + @diff.to_s + " per share."
