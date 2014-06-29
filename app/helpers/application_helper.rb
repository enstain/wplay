module ApplicationHelper

	def coiner(coins)
		locale = coins.to_s + " " + Russian.p(coins, "садакоин", "садакоина", "садакоинов")
		"#{locale}"
	end

end
