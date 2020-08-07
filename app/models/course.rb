class Course <ApplicationRecord
  validates :short_name, :presence => true, :length => {minimum: 3, maximum: 100}
  validates :name, presence: true, length: {minimum: 5, maximum: 30 }
  validates :description, presence: true, length: {minimum: 10, maximum: 300 }



end