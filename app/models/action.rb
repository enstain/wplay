class Action
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  extend Enumerize
  include ActionDispatch::Routing::PolymorphicRoutes
  include Rails.application.routes.url_helpers

  belongs_to :action_object, polymorphic: true
  belongs_to :company
  
  field :type
  enumerize :type, in: [:plain_action, :new_user, :user_get_coins, :user_get_achieve, :new_quest, :update_quest], default: :plain_action

  field :tie, type: String, default: ""

  scope :company, ->(company) { where(company: company) }

  def get_content
  	@link = ActionController::Base.helpers.link_to self.action_object.name, polymorphic_path(self.action_object)
  	locale = case self.type
	  	when "new_user"
	  	  "Сотрудник #{@link} был приглашён на сайт администратором"
	  	when "user_get_coins"
	  	  "Сотрудник #{@link} получил #{self.tie}"
      when "user_get_achieve"
        "Сотрудник #{@link} получил награду &laquo;#{self.tie}&raquo;"
      when "new_quest"
        "Добавлен новый квест #{@link} #{self.tie}"
      when "update_quest"
        "Квест #{@link} #{self.tie} был обновлён. Проверьте изменения!"
	  	else
	  	  "Новое событие на сайте"
	  	end
  	return locale
  end
end
