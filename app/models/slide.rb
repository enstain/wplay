class Slide
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :education_block

  field :title, type: String
  field :order, type: Integer

  scope :company, ->(company) { where(company: company) }
end