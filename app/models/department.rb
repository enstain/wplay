class Department
  include Mongoid::Document

  has_many :workers

  has_and_belongs_to_many :quests

  field :name
  
end
