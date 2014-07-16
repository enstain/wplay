class Achievement
  include Mongoid::Document

  belongs_to :company

  validates :name, presence: true
  validates :badge, presence: true

  field :name, type: String
  field :badge, type: String
  mount_uploader :badge, BadgeUploader

  has_many :gaven_achievements, dependent: :destroy

  scope :company, ->(company) { where(company: company) }
end
