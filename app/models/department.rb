class Department
  include Mongoid::Document

  has_many :workers, dependent: :destroy
  belongs_to :company

  has_and_belongs_to_many :quests
  has_and_belongs_to_many :education_blocks

  validates :name, presence: true
  field :name

  scope :company, ->(company) { where(company: company) }
  
end
