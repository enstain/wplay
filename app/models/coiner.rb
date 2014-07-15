class Coiner
  include Mongoid::Document

  field :first, :type => String
  field :second, :type => String
  field :third, :type => String

  embedded_in :company
end