class Assignment
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  belongs_to :worker
  belongs_to :quest
  index({ worker: 1, quest: 1 }, { unique: true, drop_dups: true })

  field :check_complete, type: Boolean, default: false
  field :progress, type: Integer, default: 0

  scope :checked, ->() { where(check_complete: true) }
  scope :non_checked, ->() { where(check_complete: false) }

  def self.completed(state)
    @completed = Array.new
    @assignments = (state=="checked") ? Assignment.checked.all : Assignment.non_checked.all
    for assignment in @assignments do
      @completed << assignment if assignment.progress == assignment.quest.iterates
    end
    @completed
  end
end