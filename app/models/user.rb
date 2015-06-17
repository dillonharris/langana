class User < ActiveRecord::Base
  before_save :encrypt_mobile_confirmation_token
  attr_accessor :mobile_confirmation_token
  has_secure_password

  has_many :work_references_received, class_name: "WorkReference", foreign_key: :worker_user_id
  has_many :work_references_written, class_name: "WorkReference", foreign_key: :employer_user_id

  mount_uploader :profile_picture, ProfilePictureUploader

  validates_presence_of :first_name, :last_name, :mobile_number

  validates :mobile_number, presence: true,
#                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6, allow_blank: true }

  def encrypt_mobile_confirmation_token
    if mobile_confirmation_token.present?
      self.mobile_token_salt = BCrypt::Engine.generate_salt
      self.mobile_confirmation_token_digest = BCrypt::Engine.hash_secret(mobile_confirmation_token, mobile_token_salt)
    end
  end

  def self.authenticate(mobile_number, password)
    user = User.find_by(mobile_number: mobile_number)
    user && user.authenticate(password)
  end
end
