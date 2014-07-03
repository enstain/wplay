class Action
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  extend Enumerize

  belongs_to :action_object, polymorphic: true
  
  field :type
  enumerize :type, in: [:plain_action, :new_user, :user_get_coins], default: :plain_action

  field :content, type: String
end
