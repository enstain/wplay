class Worker
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::MultiParameterAttributes
  extend Enumerize

  before_save :ensure_authentication_token

  belongs_to :company

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  validates :name, presence: true
  validates :department, presence: true

  field :name, type: String
  belongs_to :department
  has_many :actions, as: :action_object, dependent: :destroy

  has_and_belongs_to_many :quests
  has_many :assigned_quests, :foreign_key => 'worker_id', :class_name => "Quest"

  field :coins, type: Integer, default: 0
  field :xp, type: Integer, default: 0
  field :xp_current, type: Integer, default: 0
  field :level, type: Integer, default: 0

  field :avatar, type: String
  mount_uploader :avatar, AvatarUploader

  field :sex, type: String
  enumerize :sex, in: [:male, :female], default: :male

  field :birth, type: Date
  field :contacts, type: String
  field :about, type: String
  field :education, type: String

  field :authentication_token, type: String

  scope :company, ->(company) { where(company: company) }

  def get_avatar
    get_avatar = self.avatar? ? self.avatar : "ava_default.gif"
  end

  def get_thumb_avatar
    get_thumb_avatar = self.avatar? ? self.avatar.thumb : "ava_default.gif"
  end

  def xp_to_next_level
    (self.level+1)*10
  end

  def place_in_rating
    @workers = Worker.company(self.company).all.order_by(xp: -1).to_a
    @workers.index(self) + 1
  end

  def raise_xp(coins)
    self.xp += coins
    self.xp_current += coins
    while (self.xp_current >= self.xp_to_next_level)
      self.xp_current -= self.xp_to_next_level
      self.level += 1
    end
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def legale_quests
    @quests_for_all = Quest.company(self.company).for_all.all.to_a
    @quests_for_my_department = self.department.quests.all.to_a
    @quests_for_me = self.quests.all.to_a
    return @quests_for_all + @quests_for_my_department + @quests_for_me
  end

  def in_legale_quests(quest)
    self.legale_quests.include?(quest)
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Worker.where(authentication_token: token).first
    end
  end

end
