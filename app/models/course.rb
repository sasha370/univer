class Course <ApplicationRecord
  validates :short_name, :presence => true, :length => {minimum: 3, maximum: 100}
  validates :name, presence: true, length: {minimum: 5, maximum: 50 }
  validates :description, presence: true, length: {minimum: 10, maximum: 3000 }

  # Courses имеют иного отношений с таблицей Студент,Курс
  has_many :student_courses
  # Courses имеет множество отношения с Курсами, черезтаблицу Student_course
  has_many :students, through: :student_courses

end