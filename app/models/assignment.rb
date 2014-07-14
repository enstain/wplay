class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :worker
  belongs_to :quest
  index({ worker: 1, quest: 1 }, { unique: true, drop_dups: true })

  field :check_complete, type: Boolean, default: false
  field :progress, type: Integer, default: 0
end