class Company
  include Mongoid::Document

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true

  validates :name,  :presence => true,
                    :uniqueness => true,
                    :length => {:minimum => 2, :maximum => 254}
                   
  validates :subdomain, :presence => true, 
                    :length => {:minimum => 2, :maximum => 20},
                    :uniqueness => true,
                    :format => {:with => /[a-z-_0-9]/i}

  field :name, type: String
  field :subdomain, type: String

  has_many :admins, dependent: :destroy
  has_many :workers, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :quests, dependent: :destroy

  accepts_nested_attributes_for :admins
end
