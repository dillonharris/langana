class User < ActiveRecord::Base
  has_secure_password

  has_many :references, class_name: 'Review', foreign_key: :reviewed_id, dependent: :delete_all
  has_many :reviewed, class_name: 'Review', foreign_key: :reference_id, dependent: :delete_all

  validates_presence_of :first_name, :last_name, :mobile_number

  validates :mobile_number, presence: true,
#                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6, allow_blank: true }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(mobile_number, password)
    user = User.find_by(mobile_number: mobile_number)
    user && user.authenticate(password)
  end
end
