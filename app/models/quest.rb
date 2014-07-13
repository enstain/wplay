class Quest
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  extend Enumerize

  belongs_to :company
  has_many :actions, as: :action_object, dependent: :destroy

  field :name, type: String
  
  field :target, type: String
  enumerize :target, in: [:all, :department, :person], default: :all

  #has_many :appoints

  has_and_belongs_to_many :workers
  has_and_belongs_to_many :departments

  has_many :assignments

  field :limitation, type: DateTime
  field :reward, type: Integer, default: 1
  field :description, type: String
  field :iterates, type: Integer, default: 1

  scope :company, ->(company) { where(company: company) }
  scope :for_all, ->() { where(target: :all) }

  def get_thumb_avatar
    get_thumb_avatar = false ? self.avatar.thumb : "ava_default.gif"
  end

  def assigned_workers
    Worker.in(id: appointments.map(&:worker_id))
  end

end
