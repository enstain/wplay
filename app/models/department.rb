class Department
  include Mongoid::Document

  has_many :workers

  field :name
  
end
