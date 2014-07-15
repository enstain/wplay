module ApplicationHelper

	def coiner(coins)
		@company = current_company
		@coins = @company.coiner ? Russian.p(coins, @company.coiner.first, @company.coiner.second, @company.coiner.third) : Russian.p(coins, "монета", "монеты", "монет")
		locale = coins.to_s + " " + @coins
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

	def quest_limitation(date)
		locale = case true
			when Date.today.to_s == date.strftime("%Y-%m-%d")
				Russian::strftime(date, "Сегодня в %H:%M")
			when Date.tomorrow.to_s == date.strftime("%Y-%m-%d")
				Russian::strftime(date, "Завтра в %H:%M")
			else
				Russian::strftime(date, "%d %B в %H:%M")
			end
		"#{locale}"
	end

	def quest_endtime(quest)
		quest.limitation? ? (quest_limitation(quest.limitation)) : "бессрочно"
	end

	def quest_for(quest)
		@names = Array.new
		case quest.target
		  when "all"
		  	@tie = "для всех"
		  when "department"
		  	quest.departments.each do |dep| @names << dep.name end
		  	@tie = (@names.count > 1) ? "для отделов: #{@names.join(", ")}" : "для отдела: #{@names}"
		  when "person"
		  	quest.workers.each do |worker| @names << worker.name end
		  	@tie = (@names.count > 1) ? "для сотрудников: #{@names.join(", ")}" : "для сотрудника: #{@names}"
		  end
		@tie
	end

end
