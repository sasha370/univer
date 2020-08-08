class StudentCourse < ApplicationRecord

  # Зависят от Student и Course
  belongs_to :student
  belongs_to :course
end
