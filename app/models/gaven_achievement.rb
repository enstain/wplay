class GavenAchievement
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :worker
  belongs_to :achievement
  index({ worker: 1, achievement: 1 }, { unique: true, drop_dups: true })

  field :count, type: Integer, default: 1

end