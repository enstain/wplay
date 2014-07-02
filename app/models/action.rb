class Action
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :action_object, polymorphic: true
  
  field :content, type: String
end
