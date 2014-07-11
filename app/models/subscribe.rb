class Subscribe
  include Mongoid::Document

  validates :email, presence: true, uniqueness: true
  field :email, type: String
  
end
