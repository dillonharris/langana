class Review < ActiveRecord::Base
  belongs_to :reviewed, class_name: "User"
  belongs_to :reference, class_name: "User"

  validates :work, presence: true
  validates :reviewed, presence: true
  validates :reference, presence: true

end
