class Worker
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Mongoid::MultiParameterAttributes

  after_create :mail_create
  before_save :ensure_authentication_token

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
  field :coins, type: Integer, default: 0
  field :level, type: Integer, default: 0

  field :avatar, type: String
  mount_uploader :avatar, AvatarUploader

  field :birth, type: Date
  field :contacts, type: String
  field :about, type: String
  field :education, type: String

  field :authentication_token, type: String

  def get_avatar
    get_avatar = self.avatar? ? self.avatar : "ava_default.gif"
  end

  def get_thumb_avatar
    get_thumb_avatar = self.avatar? ? self.avatar.thumb : "ava_default.gif"
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def mail_create
    ContactMailer.welcome_email(self).deliver
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Worker.where(authentication_token: token).first
    end
  end

end
