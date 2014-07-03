module ApplicationHelper

	def coiner(coins)
		locale = coins.to_s + " " + Russian.p(coins, "садакоин", "садакоина", "садакоинов")
		"#{locale}"
	end

	def action_date(date)
		locale = case true
			when Date.today.to_s == date.strftime("%Y-%m-%d")
				Russian::strftime(date, "Сегодня в %H:%M")
			when Date.yesterday.to_s == date.strftime("%Y-%m-%d")
				Russian::strftime(date, "Вчера в %H:%M")
			else
				Russian::strftime(date, "%d %B в %H:%M")
			end
		"#{locale}"
	end

end
