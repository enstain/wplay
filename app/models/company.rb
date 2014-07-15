class Company
  include Mongoid::Document

  before_save :downme

  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true

  validates :name,  :presence => true,
                    :uniqueness => true,
                    :length => {:minimum => 2, :maximum => 254}
                   
  validates :subdomain, :presence => true, 
                    :length => {:minimum => 2, :maximum => 20},
                    :uniqueness => true,
                    :format => {:with => /\A[a-z0-9\-\_]+[^\s]+\z/i}


  field :name, type: String
  field :subdomain, type: String

  has_many :admins, dependent: :destroy
  has_many :workers, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :quests, dependent: :destroy

  embeds_one :coiner

  accepts_nested_attributes_for :admins

  private 
  def downme
    self.subdomain.downcase!
  end
end
