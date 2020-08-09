class Student < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {minimum: 5, maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  # Добавляем секретку для хранения паролей
  has_secure_password

  # Student имеют иного отношений с таблицей Студент,Курс
  has_many :student_courses
  # Студент имеет множество отношения с Курсами, черезтаблицу Student_course
  has_many :courses, through: :student_courses

  # Проверяем админ ли пользователь? Возвращает true /false
  def is_admin?
    admin
  end


end