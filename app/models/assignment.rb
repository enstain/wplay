class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :worker
  belongs_to :quest
end