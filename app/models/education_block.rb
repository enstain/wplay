class EducationBlock
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :company
  has_and_belongs_to_many :departments

  has_many :slides, dependent: :destroy

  field :name, type: String
  field :order, type: Integer

  scope :company, ->(company) { where(company: company) }
end