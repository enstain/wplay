class Appointment
  include Mongoid::Document

  belongs_to :appointed, polymorphic: true
  belongs_to :quest
end