class Company
  include Mongoid::Document

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true

  field :name, type: String
  field :subdomain, type: String

  has_many :admins
  has_many :workers
  has_many :actions
  has_many :departments
  has_many :quests
end
