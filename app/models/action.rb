class Action
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  extend Enumerize

  belongs_to :action_object, polymorphic: true
  
  field :type
  enumerize :type, in: [:plain_action, :new_user, :user_get_coins], default: :plain_action

  field :tie, type: String, default: ""

  def get_content
  	@link = ActionController::Base.helpers.link_to self.action_object.name, Rails.application.routes.url_helpers.worker_path(self.action_object)
  	locale = case self.type
	  	when "new_user"
	  	  "Сотрудник #{@link} был приглашён на сайт администратором"
	  	when "user_get_coins"
	  	  "Сотрудник #{@link} получил #{self.tie}"
	  	else
	  	  "Новое событие на сайте"
	  	end
  	return locale
  end
end
