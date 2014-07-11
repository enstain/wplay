class Quest
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  extend Enumerize

  belongs_to :company

  field :name, type: String
  
  field :target, type: String
  enumerize :target, in: [:all, :department, :person], default: :all

  #has_many :appoints

  has_and_belongs_to_many :workers
  has_and_belongs_to_many :departments

  #has_many :departments, through: :appoints, source: :appointment, :source_type => 'Department'
  #has_many :workers, through: :appoints, source: :appointment, :source_type => 'Worker'

  field :limitation, type: DateTime
  field :reward, type: Integer, default: 1
  field :description, type: String
  field :iterates, type: Integer, default: 1

  scope :company, ->(company) { where(company: company) }

  def get_thumb_avatar
    get_thumb_avatar = false ? self.avatar.thumb : "ava_default.gif"
  end
end
