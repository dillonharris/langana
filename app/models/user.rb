class User < ActiveRecord::Base
  has_secure_password

  has_many :references, class_name: 'Review', foreign_key: :reviewed_id, dependent: :delete_all
  has_many :reviewed, class_name: 'Review', foreign_key: :reference_id, dependent: :delete_all

  validates :name, presence: true

  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6, allow_blank: true }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end
end