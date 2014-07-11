class Department
  include Mongoid::Document

  has_many :workers
  belongs_to :company

  has_and_belongs_to_many :quests

  field :name

  scope :company, ->(company) { where(company: company) }
  
end
