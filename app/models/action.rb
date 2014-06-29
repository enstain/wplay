class Action
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  
  field :content, type: String
end
