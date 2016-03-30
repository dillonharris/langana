class Worker < ActiveRecord::Base
  before_save :encrypt_mobile_confirmation_code
  before_validation :format_mobile_number
  attr_accessor :mobile_confirmation_code
  has_secure_password

  has_many :work_references_received, class_name: "WorkReference", foreign_key: :worker_user_id
  
  mount_uploader :profile_picture, ProfilePictureUploader
  
  validates_presence_of :first_name, :last_name, :mobile_number

  validates :mobile_number, presence: true,
    length: { minimum: 12, maximum: 12, allow_blank: false },
                        format: /\+\d{11}\z/,
    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6, allow_blank: true }

  SERVICES = [
    'Gardening',
    'Domestic',
    'Nannying',
    'Labour',
    'Painting',
    'Carpentry',
    'Building',
    'Plumbing',
    'Electrical',
    'Pet care',
    'Home care',
    'Other'
  ]

  scope :workers, -> { where("role = ?", 0) }
  scope :confirmed, -> { where("confirmed_at IS NOT NULL").order(first_name: :asc) }
  scope :employers, -> { where("role = ?", 1) }
  scope :gardening, -> { where(service: "Gardening") }
  scope :domestic, -> { where(service: "Domestic") }
  scope :nannying, -> { where(service: "Nannying") }
  scope :labour, -> { where(service: "Labour") }
  scope :painting, -> { where(service: "Painting") }
  scope :carpentry, -> { where(service: "Carpentry") }
  scope :building, -> { where(service: "Building") }
  scope :plumbing, -> { where(service: "Plumbing") }
  scope :electrical, -> { where(service: "Electrical") }
  scope :pet_care, -> { where(service: "Pet care") }
  scope :home_care, -> { where(service: "Home care") }
  scope :other, -> { where(service: "Other") }
  
  WORK_PERMIT_STATUSES = [
    'South African Citizen',
    'Foreigner with work permit',
    'Foreigner without work permit'
  ]

  CITIES = [
    'Cape Town']

  def encrypt_mobile_confirmation_code
    if mobile_confirmation_code.present?
      self.mobile_code_salt = BCrypt::Engine.generate_salt
      self.mobile_confirmation_code_digest = BCrypt::Engine.hash_secret(mobile_confirmation_code, mobile_code_salt)
    end
  end

  def self.authenticate(mobile_number, password)
    mobile_number = ApplicationHelper.format_mobile(mobile_number)
    worker = Worker.find_by(mobile_number: mobile_number)
    worker && worker.authenticate(password)
  end

  def format_mobile_number
    self.mobile_number = ApplicationHelper.format_mobile(self.mobile_number)
  end

end
